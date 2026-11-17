package com.adobe.Quivus.events
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LogInCombinedEvent extends CairngormEvent
	{
		public var userName:String;
		public var passwd:String;
		public var callBack    : Function;
		
		public var KickOutPreviousSession:Boolean = false;
		
		public function LogInCombinedEvent(userName:String,  passwd:String ,callBack:Function)
		{
			super( AppController.LOGIN_COMBINED_EVENT, true, true );
			
			this.userName = userName;
			this.passwd   = passwd;
			this.callBack    = callBack ;
		}
	}
}