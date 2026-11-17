package com.adobe.Quivus.events.staticData {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadProfileBarStaticDataEvent extends CairngormEvent {
		
		

		public function LoadProfileBarStaticDataEvent(  ) {
			super( AppController.LOAD_PROFILE_BAR_STATIC_DATA_EVENT);
			
			}
		}
	}