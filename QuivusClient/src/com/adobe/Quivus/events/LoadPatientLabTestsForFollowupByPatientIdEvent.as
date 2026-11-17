package com.adobe.Quivus.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PatientAllergyDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientLabTestsForFollowupByPatientIdEvent extends CairngormEvent {
		
		
		public function LoadPatientLabTestsForFollowupByPatientIdEvent(  ) {
			super( AppController.LOAD_PATIENT_LAB_TESTS_FOR_FOLLOW_UP_BY_PATIENT_ID_EVENT);
			
			}
		}
	}