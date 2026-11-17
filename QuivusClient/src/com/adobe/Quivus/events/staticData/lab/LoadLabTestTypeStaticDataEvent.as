package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTestTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTestTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TEST_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}