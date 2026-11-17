package com.adobe.Quivus.events.viewBackground.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class  ManagePatientFollowUpInstructionEvent extends CairngormEvent {

		public function  ManagePatientFollowUpInstructionEvent() {
			super( AppController.MANAGE_PATIENT_FOLLOWUP_INSTRUCTION_EVENT);
			
			}
		}
	}