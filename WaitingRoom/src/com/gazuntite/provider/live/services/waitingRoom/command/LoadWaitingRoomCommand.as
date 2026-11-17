package com.gazuntite.provider.live.services.waitingRoom.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.delegate.LoadWaitingRoomDelegate;
	import com.gazuntite.provider.live.services.waitingRoom.dto.AppointmentDTO;
	import com.gazuntite.provider.live.services.waitingRoom.event.LoadWaitingRoomEvent;
	import com.gazuntite.provider.live.services.waitingRoom.model.WRModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadWaitingRoomCommand implements Command
	{
		private var model:WRModelLocator = WRModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadWaitingRoomDelegate;
		
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadWaitingRoomDelegate( responder );			
			
			var LE:LoadWaitingRoomEvent = cgEvent as LoadWaitingRoomEvent;
			
			delegate.LoadWaitingRoom(LE.stationId);
		}
		private function onSuccess(event:ResultEvent):void
		{
			var xAppointments:XML = event.result.Appointments[0];
			var xAppointmentlist:XMLList = xAppointments.Appointment;
			if(model.AppointmentsList == null)
				model.AppointmentsList = new ArrayCollection();
			else
				model.AppointmentsList.removeAll();
			
			for(var i:uint = 0; i < xAppointmentlist.length(); i++)
			{
				var aAppointmentDTO:AppointmentDTO = new AppointmentDTO();
				aAppointmentDTO.FromXML(xAppointmentlist[i]);
				model.AppointmentsList.addItem(aAppointmentDTO);
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show(event.toString() , "LoadWaitingRoomCommand Eror" , 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}