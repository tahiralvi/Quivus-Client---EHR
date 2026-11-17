package com.adobe.Quivus.events.patientProfile {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientProfileEvent extends CairngormEvent {
		
		public var patientId : int;
		

		public function LoadPatientProfileEvent( patientId : int ) {
			super( AppController.LOAD_PATIENT_PROFILE_EVENT);
			this.patientId = patientId;
			
			}
		}
	}