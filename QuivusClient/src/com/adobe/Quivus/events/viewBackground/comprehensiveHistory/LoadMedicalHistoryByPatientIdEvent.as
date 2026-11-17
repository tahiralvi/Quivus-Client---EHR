package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadMedicalHistoryByPatientIdEvent extends CairngormEvent {
		
		
	

		public function LoadMedicalHistoryByPatientIdEvent( ) {
			super( AppController.LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}