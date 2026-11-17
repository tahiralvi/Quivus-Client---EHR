package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class GetProviderInsuranceDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function GetProviderInsuranceDelegate(responder:IResponder)
		{
			this.responder 		= responder;		
			var url:String      = AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_PROVIDER_INSUANCE_BY_USER_ID;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function GetProviderInsuranceList(userId:int, clinicBranchId:int ):void
		{			
			service.showBusyCursor = true;
			service.url = service.url + "/" + userId + "/" + clinicBranchId;
			service.resultFormat = "e4x";
			service.send();				
			trace( "GetProviderInsuranceDelegate: ", service.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//logger.debug( "GetProviderInsuranceDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			//logger.debug( "GetProviderInsuranceDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
	}
}