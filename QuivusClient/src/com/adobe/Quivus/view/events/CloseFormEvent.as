package com.adobe.Quivus.view.events
{
	import flash.events.Event;
	
	public class CloseFormEvent extends Event
	{
		public static const CLOSE_FORM_EVENT:String = "CloseFormEvent";
		
		public function CloseFormEvent()
		{
			super(CLOSE_FORM_EVENT, true, false);
		}
	}
}