package com.gazuntite.provider.live.services.waitingRoom.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.waitingRoom.delegate.LoadAllStationsByClinicIdWRDelegate;
	import com.gazuntite.provider.live.services.waitingRoom.dto.StaticDataDTO;
	import com.gazuntite.provider.live.services.waitingRoom.event.LoadAllStationsByClinicIdWREvent;
	import com.gazuntite.provider.live.services.waitingRoom.model.WRModelLocator;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllStationsByClinicIdWRCommand implements Command
	{
		private var model:WRModelLocator = WRModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllStationsByClinicIdWRDelegate;
		
		
		public function execute(cgEvent:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllStationsByClinicIdWRDelegate( responder );			
			
			var LE:LoadAllStationsByClinicIdWREvent = cgEvent as LoadAllStationsByClinicIdWREvent;
			
			delegate.LoadAllStationsByClinicId(model.loggedInUserSelectedBranchId);
		}
		private function onSuccess(event:ResultEvent):void
		{
			var xStation:XML = event.result.Stations[0];
			
			var stdata:StaticDataDTO = WRModelLocator.getInstance().StaticData;
			stdata.FromXML( xStation );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show(event.toString(),"LoadAllStationsByClinicIdCommand", 4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}