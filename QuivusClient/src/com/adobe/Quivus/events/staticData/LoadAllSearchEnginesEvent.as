package com.adobe.Quivus.events.staticData {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllSearchEnginesEvent extends CairngormEvent {
		
		

		public function LoadAllSearchEnginesEvent( ) {
			super( AppController.LOAD_ALL_SEARCH_ENGINS_EVENT);
			
			}
		}
	}