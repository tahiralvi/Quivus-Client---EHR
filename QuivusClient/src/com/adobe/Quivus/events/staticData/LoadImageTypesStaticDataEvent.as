package com.adobe.Quivus.events.staticData {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadImageTypesStaticDataEvent extends CairngormEvent {
		
		

		public function LoadImageTypesStaticDataEvent(  ) {
			super( AppController.LOAD_IMAGE_TYPES_STATIC_DATA_EVENT);
			
			}
		}
	}