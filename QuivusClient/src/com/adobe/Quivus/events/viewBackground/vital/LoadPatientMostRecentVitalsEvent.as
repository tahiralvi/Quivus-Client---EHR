package com.adobe.Quivus.events.viewBackground.vital {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientMostRecentVitalsEvent extends CairngormEvent {
		

		public function LoadPatientMostRecentVitalsEvent( ) {
			super( AppController.LOAD_PATIENT_MOST_RECENT_VITALS_EVENT);
			
			}
		}
	}