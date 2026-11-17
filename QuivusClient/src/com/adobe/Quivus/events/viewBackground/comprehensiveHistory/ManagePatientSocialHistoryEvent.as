package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class ManagePatientSocialHistoryEvent extends CairngormEvent {
		
		
		

		public function ManagePatientSocialHistoryEvent( ) {
			super( AppController.MANAGE_PATIENT_SOCIAL_HISTORY_EVENT);		
			
			}
		}
	}