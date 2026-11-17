package com.gazuntite.provider.live.services.waitingRoom.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.delegate.ManageAppointmentWaitingRoomDelegate;
	import com.gazuntite.provider.live.services.waitingRoom.event.ManageAppointmentWaitingRoomEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	
	public class ManageAppointmentWaitingRoomCommand implements Command
	{
		
		private var responder:Responder;
		private var delegate:ManageAppointmentWaitingRoomDelegate;
		public var functionName : Function;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageAppointmentWaitingRoomDelegate( responder );			
			
			var LE:ManageAppointmentWaitingRoomEvent = cgEvent as ManageAppointmentWaitingRoomEvent;
			this.functionName = LE.functionName;
			
			delegate.ManageAppointment(LE.xml, LE.providerId, LE.userTypeId);
		}
		private function onSuccess(event:Event):void
		{
			var strResult:String = event.toString();
			
			if(this.functionName != null)
			{
				this.functionName();
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:IOErrorEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show(event.toString(), ' WR ManageAppointmentCommand Service Error', 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}