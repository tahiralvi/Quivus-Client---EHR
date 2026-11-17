package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientVisitListEvent extends CairngormEvent {
		
		public var patientId : int;
		public var showAll : Boolean;
		

		public function LoadPatientVisitListEvent(patientId : int, showAll : Boolean) {
			super( AppController.LOAD_PATIENT_VISIT_LIST_EVENT);
			this.patientId = patientId;
			this.showAll = showAll;
			
			}
		}
	}