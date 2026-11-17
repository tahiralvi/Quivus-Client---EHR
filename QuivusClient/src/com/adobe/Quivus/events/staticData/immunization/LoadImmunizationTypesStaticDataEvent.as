package com.adobe.Quivus.events.staticData.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadImmunizationTypesStaticDataEvent extends CairngormEvent {
		
		

		public function LoadImmunizationTypesStaticDataEvent(  ) {
			super( AppController.LOAD_IMMUNIZATION_TYPES_STATIC_DATA_EVENT);
			
			}
		}
	}