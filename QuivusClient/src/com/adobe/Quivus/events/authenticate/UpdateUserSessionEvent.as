package com.adobe.Quivus.events.authenticate
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.UserSessionDTO;

	public class UpdateUserSessionEvent extends CairngormEvent 
	{
		public var sessionDTO : UserSessionDTO;
	
		public function UpdateUserSessionEvent(sessionDTO : UserSessionDTO   )
		{
			super( AppController.UPDATE_USER_SESSION_EVENT);
			this.sessionDTO = sessionDTO;
			
		}
	}
}