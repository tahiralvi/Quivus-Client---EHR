package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class LoadPatientDocumentByClinicIdEvent extends CairngormEvent {
		
		public var pageNo 		: int;
		

		public function LoadPatientDocumentByClinicIdEvent( pageNo 		: int) {
			super( DMAppController.LOAD_PATIENT_DOCUMENT_BY_CLINIC_ID_EVENT);
			this.pageNo = pageNo;
			
			}
		}
	}