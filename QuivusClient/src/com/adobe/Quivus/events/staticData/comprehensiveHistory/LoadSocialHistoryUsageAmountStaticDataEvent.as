package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadSocialHistoryUsageAmountStaticDataEvent extends CairngormEvent {
		
		

		public function LoadSocialHistoryUsageAmountStaticDataEvent( ) {
			super( AppController.LOAD_SOCIAL_HISTORY_USAGE_AMOUNT_STATIC_DATA_EVENT);
			
			}
		}
	}