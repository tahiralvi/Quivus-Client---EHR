package com.gazuntite.provider.live.services.documentMgmt.event.staticData {

	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadDocumentSectionTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadDocumentSectionTypeStaticDataEvent(  ) {
			super( DMAppController.LOAD_DOCUMENT_SECTION_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}