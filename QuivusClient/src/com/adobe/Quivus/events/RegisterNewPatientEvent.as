package com.adobe.Quivus.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;
	
	[Deprecated("this registers a patient in one call, but currently, registration is done in multiple-calls")]
	public class RegisterNewPatientEvent extends CairngormEvent {
		
		public var registrationDTO : RegistrationDTO;
		

		public function RegisterNewPatientEvent( registrationDTO : RegistrationDTO ) {
			super( AppController.REGISTER_NEW_PATIENT_EVENT);
			this.registrationDTO = registrationDTO;
			
			}
		}
	}