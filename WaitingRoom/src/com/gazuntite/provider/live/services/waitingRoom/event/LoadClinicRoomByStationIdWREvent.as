package com.gazuntite.provider.live.services.waitingRoom.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.appControllerWR.WRController;
	
	public class LoadClinicRoomByStationIdWREvent extends CairngormEvent
	{
		public var stationId:String;
		public var functionName:Function;
		
		public function LoadClinicRoomByStationIdWREvent(_stationId:String, _functionName:Function=null)
		{
			super(WRController.LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT);
			this.stationId 		= _stationId;
			this.functionName 	= _functionName;
		}
	}
}