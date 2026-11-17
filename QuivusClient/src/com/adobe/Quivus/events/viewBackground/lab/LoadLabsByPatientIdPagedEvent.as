package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadLabsByPatientIdPagedEvent extends CairngormEvent {
		
		

		public function LoadLabsByPatientIdPagedEvent() {
			super( AppController.LOAD_PATIENT_LABS_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}