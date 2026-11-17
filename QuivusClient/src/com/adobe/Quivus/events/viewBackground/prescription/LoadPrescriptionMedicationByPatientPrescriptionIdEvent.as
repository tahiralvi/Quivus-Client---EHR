package com.adobe.Quivus.events.viewBackground.prescription{

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadPrescriptionMedicationByPatientPrescriptionIdEvent extends CairngormEvent {
		
		
		/*public var patientId:int;*/

		public function LoadPrescriptionMedicationByPatientPrescriptionIdEvent( /*patientId:int*/ ) {
			super( AppController.LOAD_PRESCRIPTION_MEDICATION_BY_PATIENT_PRESCRIPTION_ID_EVENT);
			 /*this.patientId = patientId;*/
			
			}
		}
	}