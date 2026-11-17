package com.gazuntite.provider.live.services.waitingRoom.delegate
{
	import com.gazuntite.provider.live.services.waitingRoom.util.WRConstant;
	import com.gazuntite.provider.live.services.waitingRoom.util.WRSrviceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAllStationsByClinicIdWRDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadAllStationsByClinicIdWRDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= WRConstant.RESTFULL_SERVICE_BASE_URL + WRSrviceMethod.LoadAllStationsByClinicId  ;
			service 			= new HTTPService(url);
			service.url 		= url;
		}
		public function LoadAllStationsByClinicId(clinicBranchID:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url + '/' +  clinicBranchID;
			service.resultFormat = "e4x";
			service.send();	
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