package com.adobe.Quivus.events.patientProfileCustomization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadPatientProfilePopUpDataEvent extends CairngormEvent {
		
		public var patientId : int;
		

		public function LoadPatientProfilePopUpDataEvent( patientId : int ) {
			super( AppController.LOAD_PATIENT_PROFILE_POP_UP_DATA_EVENT);
			this.patientId = patientId;
			
			}
		}
	}