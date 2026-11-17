package com.adobe.Quivus.events.viewBackground.document {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class SearchPatientDocumentByPatientIdEvent extends CairngormEvent {
		
		public var searchByFieldId	: int;
		public var searchString		: String;
		public var pageNo			: int;
		
		public function SearchPatientDocumentByPatientIdEvent(searchByFieldId: int, searchString:String,pageNo:int ) {
			super( AppController.SEARCH_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT);
			
			this.searchByFieldId = searchByFieldId;
			this.searchString = searchString;
			this.pageNo = pageNo;
		}
	}
}