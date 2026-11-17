package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PatientHealthDTO;

	public class SavePatientHealthInfoEvent extends CairngormEvent 
	{
		public var healthInfo : PatientHealthDTO;
		public var patientId : int;
		public var functionName : Function;
		public var purpose		: String;
		public function SavePatientHealthInfoEvent(purpose : String,patientId : int,healthInfo : PatientHealthDTO,functionName : Function = null)
		{
			super( AppController.SAVE_PATIENT_HEALTH_HX_EVENT);
			this.healthInfo = healthInfo;
			this.patientId = patientId;
			this.purpose = purpose;
			this.functionName = functionName;
		}
	}
}