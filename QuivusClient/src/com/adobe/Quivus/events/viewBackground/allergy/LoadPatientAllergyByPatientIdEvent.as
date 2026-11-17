package com.adobe.Quivus.events.viewBackground.allergy {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PatientAllergyDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientAllergyByPatientIdEvent extends CairngormEvent {
		
		

		public function LoadPatientAllergyByPatientIdEvent(  ) {
			super( AppController.LOAD_PATIENT_ALLERGY_BY_PATIENT_ID_EVENT);
			
			}
		}
	}