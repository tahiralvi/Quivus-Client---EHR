package com.adobe.Quivus.events.security {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadUserAccessRightEvent extends CairngormEvent {
		
		
		public function LoadUserAccessRightEvent(  ) {
			super( AppController.LOAD_USER_ACCESS_RIGHT_EVENT);
			
			
			}
		}
	}