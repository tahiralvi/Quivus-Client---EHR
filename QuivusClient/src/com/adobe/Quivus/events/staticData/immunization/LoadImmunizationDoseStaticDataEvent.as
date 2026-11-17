package com.adobe.Quivus.events.staticData.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadImmunizationDoseStaticDataEvent extends CairngormEvent {
		
		public var searchCriteria 		: String;

		public function LoadImmunizationDoseStaticDataEvent( searchCriteria : String ) {
			super( AppController.LOAD_IMMUNIZATION_DOSE_STATIC_DATA_EVENT);
			this.searchCriteria = searchCriteria;
			}
		}
	}