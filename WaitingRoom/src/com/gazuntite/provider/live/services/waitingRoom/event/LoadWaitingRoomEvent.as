package com.gazuntite.provider.live.services.waitingRoom.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.appControllerWR.WRController;
	
	public class LoadWaitingRoomEvent extends CairngormEvent
	{
		public var stationId:int;
		
		public function LoadWaitingRoomEvent(_stationId:int)
		{
			super(WRController.LOAD_WAITING_ROOM_EVENT);
			this.stationId = _stationId;
		}
	}
}