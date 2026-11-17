package com.adobe.Quivus.events.staticData.recommendation {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllLinksEvent extends CairngormEvent {
		
		public var searchString:String;

		public function LoadAllLinksEvent( searchString:String) {
			super( AppController.LOAD_ALL_LINKS);
			this.searchString = searchString;
			}
		}
	}