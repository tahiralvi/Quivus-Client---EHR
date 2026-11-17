package com.adobe.Quivus.events.viewBackground.prescription{

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientPrescriptionByPatientIdEvent extends CairngormEvent {
		
		
		

		public function LoadPatientPrescriptionByPatientIdEvent(  ) {
			super( AppController.LOAD_PATEINT_PRESCRIPTION_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}