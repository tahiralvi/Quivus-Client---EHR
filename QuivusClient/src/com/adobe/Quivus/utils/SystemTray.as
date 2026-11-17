package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.model.AppModelLocator;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.net.URLRequest;
	
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class SystemTray
	{
		[Bindable]
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.utils.SystemTray");
		
		private var trayIcon:BitmapData;
		private var win:NativeWindow;
		
		
		public function SystemTray(win:NativeWindow)
		{
			this.win = win;
		}
		
		
		public function initTray():void
		{
			loadTrayIcon();
			
			win.addEventListener(Event.CLOSING, minToTray);
		}
		
		public function loadTrayIcon():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, readyToTray);
			loader.load(new URLRequest("/icons/32.png"));
		}
		
		public function minToTray(event:Event):void
		{
			if(NativeApplication.supportsSystemTrayIcon)
			{
				event.preventDefault();
				dock();
			}
			else
			{
				logger.warn( "OS NativeApplication doesn't supportsSystemTrayIcon, Gazuntite Client will be Closed. " );
			}
		}
		
		public function readyToTray(event:Event):void
		{
			trayIcon = event.target.content.bitmapData;
			
			var appMenu:NativeMenu = new NativeMenu();
			
			var openItem:NativeMenuItem = new NativeMenuItem("Open");
			var updaterItem:NativeMenuItem = new NativeMenuItem("Check for Update");
			var closeItem:NativeMenuItem = new NativeMenuItem("Exit GazuntiteOnlineClinic");
			
			var sepItem:NativeMenuItem = new NativeMenuItem("", true);
			//sepItem.isSeparator = true;
			
			openItem.addEventListener(Event.SELECT, unDock);
			updaterItem.addEventListener(Event.SELECT, checkUpdate);
			closeItem.addEventListener(Event.SELECT, closeApp);
			
			appMenu.addItem(openItem);
			appMenu.addItem(updaterItem);
			appMenu.addItem(sepItem);
			appMenu.addItem(closeItem);
			
			if(NativeApplication.supportsSystemTrayIcon){
				SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "GazuntiteOnlineClinic";
				
				SystemTrayIcon(NativeApplication.nativeApplication.icon).
					addEventListener(MouseEvent.CLICK, unDock);
				
				/*win.stage.nativeWindow.addEventListener(
					NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, winMinimized);*/
				
				SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = appMenu;
			}
			else
			{
				logger.error( "Application not ready for SystemTray, NativeApplication doesn't supportsSystemTrayIcon " );
			}
		}
		
		private function winMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void
		{
			if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
			{
				displayStateEvent.preventDefault();
				dock();
			}
		}
		
		public function dock():void
		{
			win.stage.nativeWindow.visible = false;
			
			NativeApplication.nativeApplication.icon.bitmaps = [trayIcon];
		}
		
		public function unDock(event:Event):void
		{
			win.stage.nativeWindow.visible = true;
			win.stage.nativeWindow.orderToFront();
			
			NativeApplication.nativeApplication.icon.bitmaps = [];
		}
		
		private function closeApp(event:Event):void
		{
			win.stage.nativeWindow.close();
		}
		
		private function checkUpdate(event:Event):void
		{
			win.dispatchEvent( new Event( "checkUpdate", true, true ) );
		}
		
	}
}