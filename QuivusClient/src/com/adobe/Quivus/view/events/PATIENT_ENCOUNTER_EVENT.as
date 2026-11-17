package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class PATIENT_ENCOUNTER_EVENT extends Event
	{
		public function PATIENT_ENCOUNTER_EVENT()
		{
			super(AppEventStrings.PATIENT_ENCOUNTER, bubbles, cancelable);
		}
	}
}