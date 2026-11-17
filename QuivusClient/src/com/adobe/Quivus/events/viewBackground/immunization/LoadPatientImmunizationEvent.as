package com.adobe.Quivus.events.viewBackground.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.ImmunizationDTO;

	public class LoadPatientImmunizationEvent extends CairngormEvent {
		
		public var patientId 		: int;
		

		public function LoadPatientImmunizationEvent(patientId : int) {
			super( AppController.LOAD_PATIENT_IMMUNIZATION_EVENT);
			this.patientId =patientId ;		
			
			}
		}
	}