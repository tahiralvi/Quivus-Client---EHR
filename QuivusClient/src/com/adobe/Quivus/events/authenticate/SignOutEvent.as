package com.adobe.Quivus.events.authenticate
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.UserSessionDTO;

	public class SignOutEvent extends CairngormEvent 
	{
		public var sessionDTO : UserSessionDTO;
	
		public function SignOutEvent(sessionDTO : UserSessionDTO   )
		{
			super( AppController.SIGN_OUT_EVENT);
			this.sessionDTO = sessionDTO;
			
		}
	}
}