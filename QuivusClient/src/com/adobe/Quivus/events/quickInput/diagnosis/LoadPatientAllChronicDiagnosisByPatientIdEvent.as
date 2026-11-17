package com.adobe.Quivus.events.quickInput.diagnosis
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadPatientAllChronicDiagnosisByPatientIdEvent extends CairngormEvent
	{
		public var checkOnly:Boolean;
		
		public function LoadPatientAllChronicDiagnosisByPatientIdEvent(statusCheck:Boolean = false) 
		{
			super( AppController.LOAD_PATIENT_ALL_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT);
			checkOnly = statusCheck;
		}
	}
}