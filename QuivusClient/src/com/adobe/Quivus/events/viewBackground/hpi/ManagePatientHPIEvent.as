package com.adobe.Quivus.events.viewBackground.hpi {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ManagePatientHPIEvent extends CairngormEvent {
		
		
		
		public function ManagePatientHPIEvent( ) {
			super( AppController.MANAGE_PATIENT_HPI_EVENT);
			
			
		}
	}
}