package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class EprescriptionEvent extends Event
	{
		public function EprescriptionEvent()
		{
			super(AppEventStrings.E_PRESCRIPTION_EVENT, bubbles, cancelable);
		}
	}
}