package com.adobe.Quivus.events.viewBackground.vital {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import valueObjects.VitalDTO;

	public class ManagePatientVitalsEvent extends CairngormEvent {
		
		//public var vitalDTO :VitalDTO;
		

		public function ManagePatientVitalsEvent( ) {
			super( AppController.MANAGE_PATIENT_VITALS_EVENT);
			 //this.vitalDTO = vitalDTO;
			
			}
		}
	}