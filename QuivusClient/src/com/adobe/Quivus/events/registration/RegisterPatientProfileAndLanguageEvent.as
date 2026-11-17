package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.BaseUserDTO;
	import valueObjects.PatientDTO;

	public class RegisterPatientProfileAndLanguageEvent extends CairngormEvent 
	{
		public var patientDTO : PatientDTO;
		public var patientLanguageDTOList: ArrayCollection;
		
		public var functionName : Function;
		public var purpose		: String;
		public function RegisterPatientProfileAndLanguageEvent( purpose1:String, patientDTO:PatientDTO, patientLanguageDTOList:ArrayCollection, purpose:String, functionName : Function = null )
		{
			super( AppController.REGISTER_PATIENT_PROFILE_AND_LANGUAGES_EVENT);
			this.patientDTO = patientDTO;
			this.patientLanguageDTOList = patientLanguageDTOList;
			this.purpose = purpose1;
			this.functionName = functionName;
		}
	}
}