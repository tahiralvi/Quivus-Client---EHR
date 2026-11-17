package com.adobe.Quivus.events.authenticate
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoginSuccessFullEvent extends CairngormEvent 
	{
		
	
		public function LoginSuccessFullEvent(   )
		{
			super( AppController.LOGIN_SUCCESSFULL_EVENT);
			
		}
	}
}