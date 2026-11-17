package com.gazuntite.provider.live.services.administration.delegate.locationManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadClinicRoomByStationIdDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadClinicRoomByStationIdDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_CLINIC_ROOM_BY_STATION_ID;
			service 			= new HTTPService(url);
			service.url 		= url;
		}
		
		public function LoadClinicRoomByStationId(stationId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url 		= service.url + "/" +stationId ;
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