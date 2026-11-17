package com.adobe.Quivus.events.patientProfileCustomization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadPatientHistoryPopupDataEvent extends CairngormEvent {
		
		public var dataToLoad : String;
		

		public function LoadPatientHistoryPopupDataEvent( dataToLoad : String ) {
			super( AppController.LOAD_PATIENT_HISTORY_POPUP_DATA_EVENT);
			this.dataToLoad = dataToLoad;
			
			}
		}
	}