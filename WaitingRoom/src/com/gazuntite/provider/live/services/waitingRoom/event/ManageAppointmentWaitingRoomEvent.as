package com.gazuntite.provider.live.services.waitingRoom.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.appControllerWR.WRController;
	
	public class ManageAppointmentWaitingRoomEvent extends CairngormEvent
	{
		public var xml:XML;
		public var providerId:int;
		public var userTypeId:int;
		public var functionName:Function;
		
		public function ManageAppointmentWaitingRoomEvent(_xml:XML, _providerId:int, _userTypeId:int, _functionName:Function)
		{
			super(WRController.MANAGE_APPOINTMENT_WAITING_EVENT);
			this.xml			=	_xml;
			this.providerId		= _providerId;
			this.userTypeId		= _userTypeId;
			this.functionName	= _functionName;
		}
	}
}