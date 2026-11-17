package com.adobe.Quivus.events.staticData.followUp {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadServiceTypeEvent extends CairngormEvent {
		
		public var followupDataControlTypeID:int;

		public function LoadServiceTypeEvent(followupDataControlTypeID:int ) {
			super( AppController.LOAD_SERVICE_TYPE_EVENT);
			this.followupDataControlTypeID = followupDataControlTypeID;
			}
		}
	}