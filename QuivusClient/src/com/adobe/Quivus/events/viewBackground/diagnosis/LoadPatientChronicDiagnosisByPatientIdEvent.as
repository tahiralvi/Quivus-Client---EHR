package com.adobe.Quivus.events.viewBackground.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadPatientChronicDiagnosisByPatientIdEvent extends CairngormEvent {
		
		public function LoadPatientChronicDiagnosisByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_CHRONIC_DIAGNOSIS_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}