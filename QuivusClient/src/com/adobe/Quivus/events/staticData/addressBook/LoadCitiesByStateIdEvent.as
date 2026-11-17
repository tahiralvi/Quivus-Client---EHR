package com.adobe.Quivus.events.staticData.addressBook {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class LoadCitiesByStateIdEvent extends CairngormEvent {
		
		public var stateId : int;
		public var loadFor:String
		public function LoadCitiesByStateIdEvent( stateId : int, loadFor:String ) {
			super( AppController.LOAD_CITIES_BY_STATE_ID_EVENT);
			this.stateId = stateId;
			this.loadFor = loadFor;
			}
		}
	}