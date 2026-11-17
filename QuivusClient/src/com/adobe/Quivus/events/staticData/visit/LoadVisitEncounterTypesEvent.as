package com.adobe.Quivus.events.staticData.visit {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadVisitEncounterTypesEvent extends CairngormEvent {
		
		

		public function LoadVisitEncounterTypesEvent(  ) {
			super( AppController.LOAD_VISIT_ENCOUNTER_TYPES_EVENT);
			
			}
		}
	}