package com.gazuntite.provider.live.services.billing.delegate.ClaimManagement
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ClaimPatientSearchDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function ClaimPatientSearchDelegate(responder	:IResponder)
		{
			this.responder 		= responder;
			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_CLAIM_PATIENTS_BY_CLINIC;
			service 			= new HTTPService(url);
			service.url 		= url;	
			service.requestTimeout = 60;
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		public function SearchClaimPatientList(clinicBranchId:int):void
		{			
			service.showBusyCursor = true;
			
			service.url = service.url + "/" + clinicBranchId;
			
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "ClaimPatientSearchDelegate", service.url );
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