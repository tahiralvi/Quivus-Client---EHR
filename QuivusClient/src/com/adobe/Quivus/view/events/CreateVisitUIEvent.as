package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class CreateVisitUIEvent extends Event
	{
		public var createNewVisit:Boolean = true;
		public var visitDate:Date = new Date();
		
		public function CreateVisitUIEvent()
		{
			super(AppEventStrings.CREATE_PATIENT_VISIT_EVENT, true, cancelable);
		}
	}
}