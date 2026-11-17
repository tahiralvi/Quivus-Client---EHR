package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadSocialHistoryTypesEvent extends CairngormEvent {
		
		

		public function LoadSocialHistoryTypesEvent( ) {
			super( AppController.LOAD_SOCIAL_HISTORY_TYPES_EVENT);
			
			}
		}
	}