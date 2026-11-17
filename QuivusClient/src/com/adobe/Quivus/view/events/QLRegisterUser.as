package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class QLRegisterUser extends Event
	{
		
		public function QLRegisterUser()
		{
			super(AppEventStrings.REGISTER_USER, bubbles, cancelable);
		}
	}
}