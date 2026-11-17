package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class ManagePatientMedicalHistoryEvent extends CairngormEvent {
		
		
		

		public function ManagePatientMedicalHistoryEvent( ) {
			super( AppController.MANAGE_PATIENT_MEDICAL_HISTORY_EVENT);		
			
			}
		}
	}