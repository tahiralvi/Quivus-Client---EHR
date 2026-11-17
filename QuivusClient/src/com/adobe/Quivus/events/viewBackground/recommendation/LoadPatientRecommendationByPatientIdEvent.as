package com.adobe.Quivus.events.viewBackground.recommendation{

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientRecommendationByPatientIdEvent extends CairngormEvent {
		
		
		

		public function LoadPatientRecommendationByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_RECOMMENDATION_BY_PATIENT_ID_EVENT);
			 
			
			}
		}
	}