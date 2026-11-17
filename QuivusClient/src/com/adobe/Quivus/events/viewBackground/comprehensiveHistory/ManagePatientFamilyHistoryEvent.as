package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class ManagePatientFamilyHistoryEvent extends CairngormEvent {
		
		
		

		public function ManagePatientFamilyHistoryEvent( ) {
			super( AppController.MANAGE_PATIENT_FAMILY_HISTORY_EVENT);		
			
			}
		}
	}