package com.adobe.Quivus.events.viewBackground.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class  LoadPatientFollowUpByPatientIdEvent extends CairngormEvent {

		public function  LoadPatientFollowUpByPatientIdEvent() {
			super( AppController.LOAD_PATIENT_FOLLOWUP_BY_PATIENT_ID_EVENT);
			
			}
		}
	}