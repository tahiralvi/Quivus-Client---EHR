package com.adobe.Quivus.events.ePrescription {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class PrepareLoginCallForEprescriptionEvent extends CairngormEvent {
		
		

		public function PrepareLoginCallForEprescriptionEvent(  ) {
			super( AppController.PREPARE_LOGIN_CALL_FOR_E_PRESCRIPTION_EVENT);
			
			}
		}
	}