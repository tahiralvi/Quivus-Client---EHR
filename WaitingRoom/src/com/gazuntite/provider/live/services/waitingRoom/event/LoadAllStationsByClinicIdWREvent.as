package com.gazuntite.provider.live.services.waitingRoom.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.appControllerWR.WRController;
	
	public class LoadAllStationsByClinicIdWREvent extends CairngormEvent
	{
		public function LoadAllStationsByClinicIdWREvent()
		{
			super(WRController.LOAD_ALL_STATIONS_BY_CLINIC_ID_EVENT);
		}
	}
}