package com.adobe.Quivus.events.quickLink {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadUserQuickLinksEvent extends CairngormEvent {
		
		public static var isAlreadyLoaded:Boolean= false;
		
		public function LoadUserQuickLinksEvent( ) {
			super( AppController.LOAD_USER_QUICK_LINKS_EVENT);
			
			}
		}
	}