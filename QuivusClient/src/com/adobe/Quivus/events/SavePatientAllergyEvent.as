package com.adobe.Quivus.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PatientAllergyDTO;
	import com.adobe.Quivus.appController.AppController;

	public class SavePatientAllergyEvent extends CairngormEvent {
		
		public var patientAllergyDTO : PatientAllergyDTO;
		

		public function SavePatientAllergyEvent( patientAllergyDTO : PatientAllergyDTO ) {
			super( AppController.SAVE_PATIENT_ALLERGY_EVENT);
			this.patientAllergyDTO = patientAllergyDTO;
			
			}
		}
	}