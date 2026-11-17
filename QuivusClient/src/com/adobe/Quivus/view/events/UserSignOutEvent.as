package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;

	public class UserSignOutEvent extends Event
	{
		public var UserName:String;
		public var forceSilent:Boolean = false;
		public function UserSignOutEvent(userName:String)
		{
			super(AppEventStrings.USER_SIGN_OUT_EVENT, true, true);
			UserName = userName
		}
	}
}