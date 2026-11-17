package com.adobe.Quivus.events.viewBackground.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class  ManagePatientFollowUpEvent extends CairngormEvent {

		public function  ManagePatientFollowUpEvent() {
			super( AppController.MANAGE_PATIENT_FOLLOW_UP_EVENT);
			
			}
		}
	}