package com.adobe.Quivus.events.staticData.registration {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadSpecifiedRegistrationStaticDataEvent extends CairngormEvent {
		
		public var dataToLoad:ArrayCollection;

		public function LoadSpecifiedRegistrationStaticDataEvent(dataToLoad:ArrayCollection  ) {
			super( AppController.LOAD_SPECIFIED_REGISTRATION_STATIC_DATA_EVENT);
			this.dataToLoad = dataToLoad;
			}
		}
	}