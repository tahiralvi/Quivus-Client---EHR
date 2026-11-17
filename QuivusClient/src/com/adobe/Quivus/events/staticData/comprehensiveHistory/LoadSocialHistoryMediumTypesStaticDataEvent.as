package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadSocialHistoryMediumTypesStaticDataEvent extends CairngormEvent {
		
		

		public function LoadSocialHistoryMediumTypesStaticDataEvent( ) {
			super( AppController.LOAD_SOCIAL_HISTORY_MEDIUM_TYPES_STATIC_DATA_EVENT);
			
			}
		}
	}