package com.adobe.Quivus.events.viewBackground.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.ImmunizationDTO;

	public class LoadPatientVisitImmunizationEvent extends CairngormEvent {
		
		public var visitId 		: int;
		

		public function LoadPatientVisitImmunizationEvent(visitId : int) {
			super( AppController.LOAD_PATIENT_VISIT_IMMUNIZATION_EVENT);
			this.visitId =visitId ;		
			
			}
		}
	}