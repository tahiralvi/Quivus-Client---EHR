package com.adobe.Quivus.events.staticData.comprehensiveHistory {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadFamilyHistoryTypesEvent extends CairngormEvent {
		
		
		
		public function LoadFamilyHistoryTypesEvent( ) {
			super( AppController.LOAD_FAMILY_HISTORY_TYPES_EVENT);
			
		}
	}
}	
