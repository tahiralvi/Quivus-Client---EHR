package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.BaseUserDTO;

	public class RegisterUserProfileEvent extends CairngormEvent 
	{
		public var functionName : Function;
		
		public var purpose		: String;
	
		public function RegisterUserProfileEvent(purpose : String,functionName : Function = null)
		{
			super( AppController.REGISTER_USER_PROFILE_EVENT);
			this.functionName = functionName;
			this.purpose = purpose;
		}
	}
}