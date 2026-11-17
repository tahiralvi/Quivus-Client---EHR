package com.adobe.Quivus.events.viewBackground.hpi {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadPatientHPIByPatientIdEvent extends CairngormEvent {
		
		
		
		public function LoadPatientHPIByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_HPI_BY_PATIENT_ID_EVENT);
			
			
		}
	}
}