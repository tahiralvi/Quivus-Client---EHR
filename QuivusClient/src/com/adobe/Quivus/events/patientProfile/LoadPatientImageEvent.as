package com.adobe.Quivus.events.patientProfile {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientImageEvent extends CairngormEvent {
		
		public var userId : int;
		

		public function LoadPatientImageEvent( userId : int ) {
			super( AppController.LOAD_PATIENT_IMAGE_EVENT);
			this.userId = userId;
			
			}
		}
	}