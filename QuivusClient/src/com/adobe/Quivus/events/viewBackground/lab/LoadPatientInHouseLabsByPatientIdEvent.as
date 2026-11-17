package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientInHouseLabsByPatientIdEvent extends CairngormEvent {
		
	

		public function LoadPatientInHouseLabsByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_IN_HOUSE_LABS_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}