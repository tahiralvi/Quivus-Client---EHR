package com.adobe.Quivus.events.viewBackground.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadFamilyHistoryByPatientIdEvent extends CairngormEvent {
		
		
		

		public function LoadFamilyHistoryByPatientIdEvent(  ) {
			super( AppController.LOAD_FAMILY_HISTORY_BY_PATIENT_ID_EVENT);
			
			
			}
		}
	}