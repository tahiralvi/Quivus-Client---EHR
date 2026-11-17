package com.adobe.Quivus.events.viewBackground.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPatientFollowUpInstructionByPatientIdEvent extends CairngormEvent {
		
	
		public function LoadPatientFollowUpInstructionByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_FOLLOW_UP_INSTRUCTION_BY_PATIENT_ID_EVENT);
			
			}
		}
	}