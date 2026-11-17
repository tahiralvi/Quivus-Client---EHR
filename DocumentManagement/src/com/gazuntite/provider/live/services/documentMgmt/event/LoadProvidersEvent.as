package com.gazuntite.provider.live.services.documentMgmt.event {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.appController.DMAppController;

	public class LoadProvidersEvent extends CairngormEvent {
		
		

		public function LoadProvidersEvent(  ) {
			super( DMAppController.LOAD_PROVIDERS_EVENT);
			
			
			}
		}
	}