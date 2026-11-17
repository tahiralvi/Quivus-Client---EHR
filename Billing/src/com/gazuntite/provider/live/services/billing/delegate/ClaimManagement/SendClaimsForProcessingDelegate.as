package com.gazuntite.provider.live.services.billing.delegate.ClaimManagement
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SendClaimsForProcessingDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function SendClaimsForProcessingDelegate(responder:IResponder)
		{
			this.responder 		= responder;
			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.SEND_CLAIMS_FOR_PROCESSING;
			service 			= new HTTPService(url);
			service.url 		= url;	
			service.requestTimeout = 60;
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		public function SendWithCriteria(EDIReceiverID:int, insuranceTypeId:int, clinicBranchId:int, processedByUserID:int ):void
		{			
			service.showBusyCursor = true;
			
			service.url = service.url + "/" + EDIReceiverID + "/" + insuranceTypeId + "/" + clinicBranchId + "/" + processedByUserID;
			
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "SendClaimsForProcessingDelegate", service.url );
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