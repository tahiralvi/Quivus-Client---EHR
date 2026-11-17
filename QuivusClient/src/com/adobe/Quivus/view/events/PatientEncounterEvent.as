package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class PatientEncounterEvent extends Event
	{
		public function PatientEncounterEvent()
		{
			super(AppEventStrings.PATIENT_ENCOUNTER, bubbles, cancelable);
		}
	}
}