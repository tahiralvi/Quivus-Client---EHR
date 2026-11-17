package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTestNatureTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTestNatureTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TEST_NATURE_TYPE_STATIC_DATE_EVENT);
			
			}
		}
	}