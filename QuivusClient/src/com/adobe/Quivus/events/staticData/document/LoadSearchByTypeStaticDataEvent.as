package com.adobe.Quivus.events.staticData.document {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadSearchByTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadSearchByTypeStaticDataEvent( ) {
			super( AppController.LOAD_SEARCH_BY_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}