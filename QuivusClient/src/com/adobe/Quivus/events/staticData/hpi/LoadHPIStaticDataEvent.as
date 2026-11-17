package com.adobe.Quivus.events.staticData.hpi {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadHPIStaticDataEvent extends CairngormEvent {
		
		public var sectionId:int;
		
		public var searchString:String;

		public function LoadHPIStaticDataEvent(sectionId:int,searchString:String ) {
			super( AppController.LOAD_HPI_STATIC_DATA_EVENT);
			this.sectionId = sectionId;
			this.searchString = searchString;
			}
		}
	}