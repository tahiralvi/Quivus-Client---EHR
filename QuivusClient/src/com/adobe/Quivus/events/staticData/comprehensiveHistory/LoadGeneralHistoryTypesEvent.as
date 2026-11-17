package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadGeneralHistoryTypesEvent extends CairngormEvent {
		
		

		public function LoadGeneralHistoryTypesEvent( ) {
			super( AppController.LOAD_GENERAL_HISTORY_TYPES_EVENT);
			
			}
		}
	}