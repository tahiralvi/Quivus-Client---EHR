package com.adobe.Quivus.events.staticData.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadImmunizationSiteStaticDataEvent extends CairngormEvent {
		
		public var searchCriteria 		: String;

		public function LoadImmunizationSiteStaticDataEvent( searchCriteria : String ) {
			super( AppController.LOAD_IMMUNIZATION_SITES_STATIC_DATA_EVENT);
			this.searchCriteria = searchCriteria;
			}
		}
	}