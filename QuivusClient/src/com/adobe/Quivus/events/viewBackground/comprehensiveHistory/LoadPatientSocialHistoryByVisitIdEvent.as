package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientSocialHistoryByVisitIdEvent extends CairngormEvent {
		
		
		public var visitId:int;

		public function LoadPatientSocialHistoryByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATIENT_SOCIAL_HISTORY_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}