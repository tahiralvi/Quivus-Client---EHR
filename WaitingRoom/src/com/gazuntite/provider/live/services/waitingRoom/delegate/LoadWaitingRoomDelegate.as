package com.gazuntite.provider.live.services.waitingRoom.delegate
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRConstant;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRSrviceMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadWaitingRoomDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.zigron.provider.live.services.scheduler.delegate.LoadWaitingRoomDelegate");
		
		public function LoadWaitingRoomDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= WRConstant.RESTFULL_SERVICE_BASE_URL + WRSrviceMethod.LoadWaitingRoom  ;
			service 			= new HTTPService(url);
			service.url 		= url;
		}
		public function LoadWaitingRoom(stationId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url +'/'+ stationId ;
			service.resultFormat = "e4x";
			service.send();	
			
			trace('LoadWaitingRoomDelegate', service.url);
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}
	}
}