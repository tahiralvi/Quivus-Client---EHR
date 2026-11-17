package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientInHouseLabsByVisitIdEvent extends CairngormEvent {
		
		public var visitId:int;
		

		public function LoadPatientInHouseLabsByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATEINT_IN_HOUSE_LABS_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}