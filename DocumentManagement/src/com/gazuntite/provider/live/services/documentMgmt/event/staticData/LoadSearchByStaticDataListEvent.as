package com.gazuntite.provider.live.services.documentMgmt.event.staticData {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class LoadSearchByStaticDataListEvent extends CairngormEvent {
		
		

		public function LoadSearchByStaticDataListEvent(  ) {
			super( DMAppController.LOAD_SEARCH_BY_STATIC_DATA_LIST_EVENT);
			
			}
		}
	}