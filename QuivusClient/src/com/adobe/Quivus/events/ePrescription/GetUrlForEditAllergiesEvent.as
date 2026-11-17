package com.adobe.Quivus.events.ePrescription {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetUrlForEditAllergiesEvent extends CairngormEvent {
		
		

		public function GetUrlForEditAllergiesEvent(  ) {
			super( AppController.GET_URL_FOR_EDIT_ALLERGIES_EVENT);
		
			}
		}
	}