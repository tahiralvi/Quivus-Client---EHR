package com.adobe.Quivus.events.authenticate
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.UserSessionDTO;

	public class UpdateUserSessionStatusEvent extends CairngormEvent 
	{
		public var sessionDTO : UserSessionDTO;
		
		public function UpdateUserSessionStatusEvent(sessionDTO : UserSessionDTO   )
		{
			super( AppController.UPDATE_USER_SESSION_STATUS_EVENT);
			this.sessionDTO = sessionDTO;
			
		}
	
	}
}