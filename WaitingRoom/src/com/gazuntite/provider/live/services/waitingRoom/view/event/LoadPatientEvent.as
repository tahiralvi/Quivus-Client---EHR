package com.gazuntite.provider.live.services.waitingRoom.view.event
{	
	import flash.events.Event;
	
	public class LoadPatientEvent extends Event
	{
		public static const LOAD_PATIENT_EVENT:String = "LoadPatientEvent";
		
		public var PatientID:int;
		public var PatientUserID:int
		
		public function LoadPatientEvent(patientID:int, patientUserID:int)
		{
			super(LOAD_PATIENT_EVENT, true, false);
			PatientID 		= patientID;
			PatientUserID 	= patientUserID;
		}
	}
}