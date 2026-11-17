package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadSocialHistoryByPatientIdEvent extends CairngormEvent {
		
		
	

		public function LoadSocialHistoryByPatientIdEvent( ) {
			super( AppController.LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}