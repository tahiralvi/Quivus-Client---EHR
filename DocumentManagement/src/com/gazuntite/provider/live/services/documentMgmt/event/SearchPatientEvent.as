package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class SearchPatientEvent extends CairngormEvent {
		
		public var searchString 	: String;
		public var pageNo 			: int;

		public var functionName : Function;
		
		public function SearchPatientEvent( searchString 	: String,functionName : Function ) {
			super( DMAppController.SEARCH_PATIENT_EVENT);
			this.searchString = searchString;
			
			this.functionName = functionName;
			}
		}
	}