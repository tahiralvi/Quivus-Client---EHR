package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadInHouseLabTestTypeByClinicIdEvent extends CairngormEvent {
		
		public var func:Function;
		public function LoadInHouseLabTestTypeByClinicIdEvent(_func:Function = null ) {
			super( AppController.LOAD_IN_HOUSE_LAB_TEST_TYPE_BY_CLINIC_ID_EVENT);
			this.func 		= _func;
			}
		}
	}