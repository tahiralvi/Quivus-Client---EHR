package com.adobe.Quivus.events.staticData.physical {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadPhysicalStaticDataEvent extends CairngormEvent {
		
		public var isMale:Boolean;
		public var callForPatientData:Boolean;
		public function LoadPhysicalStaticDataEvent(isMale:Boolean ,callForPatientData:Boolean) {
			super( AppController.LOAD_PHYSICAL_STATIC_DATA_EVENT);
			this.isMale = isMale;
			this.callForPatientData = callForPatientData;
			}
		}
	}