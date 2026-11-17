package com.gazuntite.provider.live.services.documentMgmt.event.staticData {

	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadDocumentTypeStaticDataEvent extends CairngormEvent {
		
		

		public function LoadDocumentTypeStaticDataEvent(  ) {
			super( DMAppController.LOAD_DOCUMENT_TYPE_STATIC_DATA_EVENT);
			
			}
		}
	}