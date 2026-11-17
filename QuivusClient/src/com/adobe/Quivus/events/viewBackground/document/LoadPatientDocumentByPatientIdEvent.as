package com.adobe.Quivus.events.viewBackground.document {
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadPatientDocumentByPatientIdEvent extends CairngormEvent {
		
		public var pageNo:int;
		
		public function LoadPatientDocumentByPatientIdEvent(pageNo:int ) {
			super( AppController.LOAD_PATIENT_DOCUMENT_BY_PATIENT_ID_EVENT);
			
			this.pageNo = pageNo;
		}
	}
}