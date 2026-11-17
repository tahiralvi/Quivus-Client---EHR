package com.adobe.Quivus.events.viewBackground.vital {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientVitalsByPatientIdEvent extends CairngormEvent {
		
		

		public function LoadPatientVitalsByPatientIdEvent(  ) {
			super( AppController.LOAD_PATIENT_VITALS_BY_PATIENT_ID_EVENT);
			 
			
			}
		}
	}