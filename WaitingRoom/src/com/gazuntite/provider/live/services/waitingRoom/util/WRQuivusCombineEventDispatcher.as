package com.gazuntite.provider.live.services.waitingRoom.util
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.provider.live.services.waitingRoom.event.LoadAllStationsByClinicIdWREvent;

	public class WRQuivusCombineEventDispatcher
	{
		public function WRQuivusCombineEventDispatcher()
		{
		}
		
		public static function LoadWRStaticData():void
		{
			var LSE:LoadAllStationsByClinicIdWREvent	= new LoadAllStationsByClinicIdWREvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(LSE);
		}
	}
}