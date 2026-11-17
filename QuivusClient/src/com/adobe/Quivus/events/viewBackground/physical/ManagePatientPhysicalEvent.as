package com.adobe.Quivus.events.viewBackground.physical {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class ManagePatientPhysicalEvent extends CairngormEvent {
		
		
		

		public function ManagePatientPhysicalEvent( ) {
			super( AppController.MANAGE_PATIENT_PHYSICAL_EVENT);
			 
			
			}
		}
	}