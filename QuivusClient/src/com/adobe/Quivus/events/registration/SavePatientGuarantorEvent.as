package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.PatientGuarantorDTO;

	public class SavePatientGuarantorEvent extends CairngormEvent 
	{
		public var patientGuarantorDTOList : ArrayCollection;
		public var patientId : int;
		public var functionName : Function;
		
		public var purpose		: String;
		
		public function SavePatientGuarantorEvent(purpose:String,patientId : int,patientGuarantorDTOList : ArrayCollection,functionName : Function = null)
		{
			super( AppController.SAVE_PATIENT_GURANTOR_EVENT);
			this.patientGuarantorDTOList = patientGuarantorDTOList;
			this.patientId = patientId;
			this.purpose = purpose;
			this.functionName = functionName;
		}
	}
}