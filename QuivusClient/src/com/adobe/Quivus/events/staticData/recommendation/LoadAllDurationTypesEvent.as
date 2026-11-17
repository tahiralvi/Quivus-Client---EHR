package com.adobe.Quivus.events.staticData.recommendation {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllDurationTypesEvent extends CairngormEvent {
		
		

		public function LoadAllDurationTypesEvent( ) {
			super( AppController.LOAD_ALL_DURATION_TYPES);
			
			}
		}
	}