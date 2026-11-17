package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.BaseUserDTO;

	public class SavePatientEmergencyContactEvent extends CairngormEvent 
	{
		public var emergencyContatcList : ArrayCollection;
		public var patientId : int;
		public var functionName : Function;
		
		public var purpose		: String;
		
		public function SavePatientEmergencyContactEvent(purpose : String,patientId : int,emergencyContatcList : ArrayCollection,functionName : Function = null)
		{
			super( AppController.SAVE_PATIENT_EMERGENCY_CONTACT_EVENT);
			this.emergencyContatcList = emergencyContatcList;
			this.patientId = patientId;
			this.purpose = purpose;
			this.functionName = functionName;
		}
	}
}