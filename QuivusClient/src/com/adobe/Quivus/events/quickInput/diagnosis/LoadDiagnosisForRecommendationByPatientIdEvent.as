package com.adobe.Quivus.events.quickInput.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadDiagnosisForRecommendationByPatientIdEvent extends CairngormEvent {
		
		public function LoadDiagnosisForRecommendationByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_DIAGNOSIS_FOR_RECOMMENDATION_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}