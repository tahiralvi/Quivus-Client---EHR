package com.gazuntite.provider.live.services.waitingRoom.appControllerWR
{
	import com.adobe.cairngorm.control.FrontController;
	import com.gazuntite.provider.live.services.waitingRoom.command.LoadAllStationsByClinicIdWRCommand;
	import com.gazuntite.provider.live.services.waitingRoom.command.LoadClinicRoomByStationtIdWRCommand;
	import com.gazuntite.provider.live.services.waitingRoom.command.LoadWaitingRoomCommand;
	import com.gazuntite.provider.live.services.waitingRoom.command.ManageAppointmentWaitingRoomCommand;

	public class WRController extends FrontController
	{
		
		public static const LOAD_WAITING_ROOM_EVENT 			: String =	"LoadWaitingRoomEvent";
		public static const MANAGE_APPOINTMENT_WAITING_EVENT 	: String =	"ManageAppointmentWaitingRoomEvent";
		public static const LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT: String =	"LoadClinicRoomByStationtIdWREvent";
		public static const LOAD_ALL_STATIONS_BY_CLINIC_ID_EVENT: String =	"LoadAllStationsByClinicIdWREvent";
		
		
		private static var m_oWRController:WRController ;
		
		public static function getInstance():WRController 
		{
			if ( m_oWRController == null )
				m_oWRController = new WRController(new Lock());
			return m_oWRController;
		}
		
		public function WRController(lock:Lock)
		{
			if(null == lock )
				throw("Can't create object. please use getInstance() method instead ... ")
				
			addCommand(LOAD_WAITING_ROOM_EVENT,		LoadWaitingRoomCommand);
			addCommand(MANAGE_APPOINTMENT_WAITING_EVENT,	ManageAppointmentWaitingRoomCommand);
			addCommand(LOAD_CLINIC_ROOM_BY_STATION_ID_EVENT,	LoadClinicRoomByStationtIdWRCommand);
			addCommand(LOAD_ALL_STATIONS_BY_CLINIC_ID_EVENT,	LoadAllStationsByClinicIdWRCommand);
		}
	}
}
class Lock
{
	//Singlton Lock
}