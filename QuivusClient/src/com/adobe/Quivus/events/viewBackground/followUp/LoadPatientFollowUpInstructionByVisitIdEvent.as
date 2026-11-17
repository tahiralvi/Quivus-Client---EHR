package com.adobe.Quivus.events.viewBackground.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientFollowUpInstructionByVisitIdEvent extends CairngormEvent {
		
		
		public var visitId:int;

		public function LoadPatientFollowUpInstructionByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			
			}
		}
	}