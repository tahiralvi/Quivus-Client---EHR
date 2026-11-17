package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientFamilyHistoryByVisitIdEvent extends CairngormEvent {
		
		
		public var visitId:int;

		public function LoadPatientFamilyHistoryByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATIENT_FAMILY_HISTORY_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}