package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class SavePatientInsuranceEvent extends CairngormEvent 
	{
		public var patientInsuranceDTOList : ArrayCollection;
		public var patientId : int;
		public var functionName : Function;
		public var purpose		: String;
		
		public function SavePatientInsuranceEvent(purpose : String,patientId : int,patientInsuranceDTOList : ArrayCollection,functionName : Function = null)
		{
			super( AppController.SAVE_PATIENT_INSURANCE_EVENT);
			this.patientInsuranceDTOList = patientInsuranceDTOList;
			this.patientId = patientId;
			this.purpose = purpose;
			this.functionName = functionName;
		}
	}
}