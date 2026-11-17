package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientLabsByVisitIdEvent extends CairngormEvent {
		
		public var visitId:int;
		

		public function LoadPatientLabsByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATIENT_LABS_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}