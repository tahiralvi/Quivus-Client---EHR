package com.gazuntite.provider.live.services.waitingRoom.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.delegate.LoadClinicRoomByStationtIdWRDelegate;
	import com.gazuntite.provider.live.services.waitingRoom.dto.RoomDTO;
	import com.gazuntite.provider.live.services.waitingRoom.event.LoadClinicRoomByStationIdWREvent;
	import com.gazuntite.provider.live.services.waitingRoom.model.WRModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadClinicRoomByStationtIdWRCommand implements Command
	{
		private var model:WRModelLocator = WRModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadClinicRoomByStationtIdWRDelegate;
		public var functionName : Function;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadClinicRoomByStationtIdWRDelegate( responder );			
			
			var LE:LoadClinicRoomByStationIdWREvent = cgEvent as LoadClinicRoomByStationIdWREvent;
			
			if(functionName !=null)
				functionName = LE.functionName;
			
			if(LE != null)
				delegate.LoadClinicRoomByStationtId(LE.stationId);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var xRooms:XML = event.result.Rooms[0];
			var xRoomList:XMLList = xRooms.Room;
			
			if(model.ClinicRoomList == null)
				model.ClinicRoomList	= new ArrayCollection();
			else
				model.ClinicRoomList.removeAll();
			
			for( var i:int = 0; i < xRoomList.length(); i++ )
			{
				var aRoomDTO:RoomDTO = new RoomDTO();
				aRoomDTO.FromXML( xRoomList[i]);
				model.ClinicRoomList.addItem( aRoomDTO );
			}
			
			if(this.functionName != null)
			{
				this.functionName();
			}
			
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show(event.toString(), "LoadClinicRoomByStationtIdCommand", 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}