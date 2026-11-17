package com.adobe.Quivus.events.ePrescription {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetUrlForEditPrescriptionEvent extends CairngormEvent {
		
		

		public function GetUrlForEditPrescriptionEvent(  ) {
			super( AppController.GET_URL_FOR_EDIT_PRESCRIPTION_EVENT);
		
			}
		}
	}