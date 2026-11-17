package com.gazuntite.patient.visit.view.event
{
	import flash.events.Event;
	
	public class CreateVisitUIEvent extends Event
	{
		public static const CREATE_PATIENT_VISIT_EVENT:String = "CreateVisitUI";
		
		public var createNewVisit:Boolean = true;
		public var visitDate:Date = new Date();
		
		public function CreateVisitUIEvent()
		{
			super(CREATE_PATIENT_VISIT_EVENT, true, cancelable);
		}
	}
}