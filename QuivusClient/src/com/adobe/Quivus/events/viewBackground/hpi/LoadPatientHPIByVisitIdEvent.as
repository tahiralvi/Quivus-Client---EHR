package com.adobe.Quivus.events.viewBackground.hpi {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientHPIByVisitIdEvent extends CairngormEvent {
		
		
		public var visitId:int;

		public function LoadPatientHPIByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATIENT_HPI_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}