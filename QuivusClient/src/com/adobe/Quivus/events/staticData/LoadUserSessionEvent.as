package com.adobe.Quivus.events.staticData
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadUserSessionEvent extends CairngormEvent {
		
		
		
		public function LoadUserSessionEvent( ) 
		{
			super( AppController.LOAD_USER_SESSION_STATUS);
			
		}
	
	}
}