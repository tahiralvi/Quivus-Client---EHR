package com.adobe.Quivus.events.staticData.hpi {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllHPIDetailTypesEvent extends CairngormEvent {
		
		

		public function LoadAllHPIDetailTypesEvent( ) {
			super( AppController.LOAD_ALL_HPI_DETAIL_TYPES_EVENT);
			
			}
		}
	}