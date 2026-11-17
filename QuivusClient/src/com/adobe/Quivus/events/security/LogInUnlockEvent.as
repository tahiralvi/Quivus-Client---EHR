package com.adobe.Quivus.events.security
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LogInUnlockEvent extends CairngormEvent
	{
		public var userName:String;
		public var passwd:String;
		public var callBack    : Function;
		
		public function LogInUnlockEvent(userName:String,  passwd:String ,callBack:Function)
		{
			super(AppController.LOGIN_UNLOCK_EVENT, true, true );
			
			this.userName = userName;
			this.passwd   = passwd;
			this.callBack    = callBack ;
		}
	}
}