package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadClinicRoomByStationIdEvent extends CairngormEvent
	{
		public var stationId:int;
		
		public function LoadClinicRoomByStationIdEvent(_stationId:int)
		{
			super(AdminController.LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT);
			
			this.stationId = _stationId;
		}
	}
}