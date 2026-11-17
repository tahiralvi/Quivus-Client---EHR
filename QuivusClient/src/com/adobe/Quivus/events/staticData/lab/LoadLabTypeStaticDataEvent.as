package com.adobe.Quivus.events.staticData.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadLabTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadLabTypeStaticDataEvent( ) {
			super( AppController.LOAD_LAB_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}