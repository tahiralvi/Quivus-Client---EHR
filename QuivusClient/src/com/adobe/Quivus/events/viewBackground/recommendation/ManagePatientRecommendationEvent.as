package com.adobe.Quivus.events.viewBackground.recommendation{

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class ManagePatientRecommendationEvent extends CairngormEvent {
		
		
		

		public function ManagePatientRecommendationEvent( ) {
			super( AppController.MANAGE_PATIENT_TREATMENT_EVENT);
			 
			
			}
		}
	}