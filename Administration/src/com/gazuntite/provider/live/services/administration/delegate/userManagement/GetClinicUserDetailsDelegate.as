package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GetClinicUserDetailsDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function GetClinicUserDetailsDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			
			var url:String 		= AdminConstant.QUIVUS_PROVIDER_SERVICE_BASE_URL + AdminServiceMethod.LOAD_CLINIC_USERS_BASIC_INFO;
			service 			= new HTTPService(url);
			service.url 		= url;
		}
		
		public function GetProviderDetails(userID:int,clinicBranchId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.showBusyCursor = true;
			service.url = service.url + "/" + userID +"/" + clinicBranchId;// + "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			//trace( service.url );
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