package com.adobe.Quivus.events.authenticate
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LostPasswordEvent extends CairngormEvent
	{
		public var email : String;
		public var func  : Function ;
		public function LostPasswordEvent(email : String , func:Function)
		{
			super(AppController.LOST_PASSWORD_EVENT);
			this.email = email;
			this.func  = func;
			
		}
	}
}