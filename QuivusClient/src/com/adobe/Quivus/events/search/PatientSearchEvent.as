package com.adobe.Quivus.events.search {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PatientSearchEvent extends CairngormEvent {
		
		public var searchString : String;
		public var functionName : Function;

		public function PatientSearchEvent(searchString : String , functionName:Function=null ) {
			super( AppController.PATIENT_SEARCH_EVENT);
			this.searchString = searchString;
			this.functionName = functionName;
			}
		}
	}