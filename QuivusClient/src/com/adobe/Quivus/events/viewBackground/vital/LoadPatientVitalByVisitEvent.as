package com.adobe.Quivus.events.viewBackground.vital {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientVitalByVisitEvent extends CairngormEvent {
		
		public var visitId:int;
		

		public function LoadPatientVitalByVisitEvent( visitId:int) {
			super( AppController.LOAD_PATIENT_VITAL_BY_VISIT_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}