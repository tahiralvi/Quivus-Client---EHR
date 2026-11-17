package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTestSpecimenTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTestSpecimenTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TEST_SPECIMEN_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}