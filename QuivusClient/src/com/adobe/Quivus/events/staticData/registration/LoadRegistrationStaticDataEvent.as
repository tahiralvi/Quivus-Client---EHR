package com.adobe.Quivus.events.staticData.registration {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadRegistrationStaticDataEvent extends CairngormEvent {
		
		public var dataToLoad:ArrayCollection;

		public function LoadRegistrationStaticDataEvent(dataToLoad:ArrayCollection  ) {
			super( AppController.LOAD_REGISTRATION_STATIC_DATA_EVENT);
			this.dataToLoad = dataToLoad;
			}
		}
	}