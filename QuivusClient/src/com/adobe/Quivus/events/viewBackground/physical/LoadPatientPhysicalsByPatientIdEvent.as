package com.adobe.Quivus.events.viewBackground.physical {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientPhysicalsByPatientIdEvent extends CairngormEvent {
		
		
		

		public function LoadPatientPhysicalsByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_PHYSICALS_BY_PATIENT_ID_EVENT);
			 
			
			}
		}
	}