package com.adobe.Quivus.events.viewBackground.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadPatientDiagnosisAcuteByPatientIdEvent extends CairngormEvent {
		
		public function LoadPatientDiagnosisAcuteByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_DIAGNOSIS_ACUTE_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}