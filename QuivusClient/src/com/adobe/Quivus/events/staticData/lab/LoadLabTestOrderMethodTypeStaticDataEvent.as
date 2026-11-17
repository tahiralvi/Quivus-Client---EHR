package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTestOrderMethodTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTestOrderMethodTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TEST_ORDER_METHOD_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}