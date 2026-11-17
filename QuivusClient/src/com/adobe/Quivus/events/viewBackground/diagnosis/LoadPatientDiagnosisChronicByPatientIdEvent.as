package com.adobe.Quivus.events.viewBackground.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadPatientDiagnosisChronicByPatientIdEvent extends CairngormEvent {
		
		public function LoadPatientDiagnosisChronicByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_DIAGNOSIS_CHRONIC_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}