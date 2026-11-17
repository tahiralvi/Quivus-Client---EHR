package com.adobe.Quivus.events.viewBackground.diagnosis {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ManagePatientDiagnosisEvent extends CairngormEvent {
		
		public function ManagePatientDiagnosisEvent() {
			super( AppController.MANAGE_PATIENT_DIAGNOSIS_EVENT);
			
			
		}
	}
}