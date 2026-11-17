package com.adobe.Quivus.events.quickInput.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	
	public class LoadPatientDiagnosisByVisitIdEvent extends CairngormEvent {
		
		public function LoadPatientDiagnosisByVisitIdEvent() {
			super( AppController.LOAD_PATIENT_DIAGNOSIS_BY_VISITID_EVENT);
			//this.visitId = visitId;
			
		}
	}
}