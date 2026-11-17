package com.adobe.Quivus.events.viewBackground.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadPatientDiagnosisByPatientIdEvent extends CairngormEvent {
		
		public function LoadPatientDiagnosisByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_DIAGNOSIS_BY_PATIENTID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}