package com.adobe.Quivus.events.staticData.recommendation {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllPlanTypesEvent extends CairngormEvent {
		
		

		public function LoadAllPlanTypesEvent( ) {
			super( AppController.LOAD_ALL_PLAN_TYPES);
			
			}
		}
	}