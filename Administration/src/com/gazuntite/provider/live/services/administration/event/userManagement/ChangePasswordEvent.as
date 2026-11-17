package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	/*import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;*/
	
	public class ChangePasswordEvent extends CairngormEvent
	{
		
		public var resultHandlerFunction:Function;
	/*	public var user_id:String;
		public var newpass:String;
		public var oldpass:String;*/
		
		public function ChangePasswordEvent(resultHandlerFunction:Function)
		{
			super(AdminController.CHANGE_PASSWORD_EVENT);
			this.resultHandlerFunction = resultHandlerFunction;
			/*this.user_id = user_id;
			this.newpass = newpass;
			this.oldpass = oldpass;*/
		}
	}
}