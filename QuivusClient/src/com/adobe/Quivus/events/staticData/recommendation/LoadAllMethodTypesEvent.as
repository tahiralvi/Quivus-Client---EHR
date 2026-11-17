package com.adobe.Quivus.events.staticData.recommendation {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllMethodTypesEvent extends CairngormEvent {
		
		

		public function LoadAllMethodTypesEvent( ) {
			super( AppController.LOAD_ALL_METHOD_TYPES);
			
			}
		}
	}