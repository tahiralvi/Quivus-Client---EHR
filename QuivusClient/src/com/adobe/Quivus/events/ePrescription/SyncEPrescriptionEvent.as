package com.adobe.Quivus.events.ePrescription {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SyncEPrescriptionEvent extends CairngormEvent {
		
		public var visitId:int;

		public function SyncEPrescriptionEvent( visitId:int  ) {
			super( AppController.SYNC_E_PRESCRIPTION_EVENT);
			this.visitId = visitId;
			}
		}
	}