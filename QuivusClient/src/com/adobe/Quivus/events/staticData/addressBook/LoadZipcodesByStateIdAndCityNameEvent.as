package com.adobe.Quivus.events.staticData.addressBook {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class LoadZipcodesByStateIdAndCityNameEvent extends CairngormEvent {
		
		public var stateId : int;
		public var cityName : String;
		public var loadFor:String
		public function LoadZipcodesByStateIdAndCityNameEvent( stateId : int , cityName : String,loadFor : String) {
			super( AppController.LOAD_ZIPCODES_BY_STATEID_AND_CITY_NAME_EVENT);
			this.stateId = stateId;
			this.cityName = cityName;
			this.loadFor = loadFor;
			}
		}
	}