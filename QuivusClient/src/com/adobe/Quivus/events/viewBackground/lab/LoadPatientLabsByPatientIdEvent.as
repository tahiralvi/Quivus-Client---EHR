package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientLabsByPatientIdEvent extends CairngormEvent {
		
		

		public function LoadPatientLabsByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_LABS_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}