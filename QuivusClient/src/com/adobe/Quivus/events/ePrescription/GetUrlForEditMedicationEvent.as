package com.adobe.Quivus.events.ePrescription {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetUrlForEditMedicationEvent extends CairngormEvent {
		
		

		public function GetUrlForEditMedicationEvent(  ) {
			super( AppController.GET_URL_FOR_EDIT_MEDICATION_EVENT);
		
			}
		}
	}