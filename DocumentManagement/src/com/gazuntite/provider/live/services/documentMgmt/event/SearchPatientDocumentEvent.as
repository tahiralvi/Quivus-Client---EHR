package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class SearchPatientDocumentEvent extends CairngormEvent {
		
		public var searchByFieldId	: int;
		public var searchString		: String;
		public var pageNo			: int;

		public function SearchPatientDocumentEvent( searchByFieldId: int, searchString:String,pageNo:int) {
			super( DMAppController.SEARCH_PATIENT_DOCUMENT_EVENT);
			
			this.searchByFieldId = searchByFieldId;
			this.searchString = searchString;
			this.pageNo = pageNo;
			}
		}
	}