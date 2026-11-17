package com.adobe.Quivus.utils.network
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class NetworkUtil
	{
		private var url:String      	= null; 
		private var connected:Boolean 	= false; 
		private var checking:Boolean 	= false; 
		private var loader:URLLoader 	= new URLLoader();
		
		private static var instance:NetworkUtil;
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.utils.network.NetworkUtil");
		
		
		public function NetworkUtil( url:String )
		{
			if( instance )
			{
				throw("SingletonError::please use \"NetworkUtil.Network\" instead");
			}
			PingURL(url);
		}
		
		public static function get Network():NetworkUtil
		{
			if( null == instance )
			{
				instance = new NetworkUtil("http://www.google.com"); 
			}
			return instance;
		}
		
		public function PingURL(url:String):void
		{
			this.url = url;
			StartNetworkMonitor();
		}
		
		public function get IsConnected():Boolean
		{
			if( false == connected && false == checking )
			{
				checkConnection(); //try agin ...
			}
			
			return connected;
		}
		
		public function StartNetworkMonitor():void
		{
			NativeApplication.nativeApplication.removeEventListener(Event.NETWORK_CHANGE, checkConnection);
			NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, checkConnection);
			checkConnection(); // 1st call must be manual, because an event may have already occurred
		}
		
		private function checkConnection(event:Event = null):void
		{
			var r:URLRequest = new URLRequest(url);
			r.useCache 		 = false; // force a new fetch
			
			loader.removeEventListener(Event.COMPLETE, handlerEventComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handlerIoError);
			
			loader.addEventListener(Event.COMPLETE, handlerEventComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handlerIoError);
			
			loader.load(r); // execute request
			
			checking = true;
			
			logger.info( "checking internet connection by loading URI " +  url);
		}
		
		private function handlerEventComplete(event:Event):void
		{
			connected = true;
			checking = false;
		}

		private function handlerIoError(event:Event):void
		{
			connected = false;
			checking = false;
		}
	}
}