package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTestPriorityTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTestPriorityTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TEST_PRIORITY_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}