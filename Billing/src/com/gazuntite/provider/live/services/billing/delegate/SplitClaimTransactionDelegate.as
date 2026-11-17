package com.gazuntite.provider.live.services.billing.delegate
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	

	public class SplitClaimTransactionDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function SplitClaimTransactionDelegate(responder : IResponder)
		{
				this.responder = responder;				
				
				var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.SPLIT_CLAIM_TRANSACTIONS;
				service 			= new HTTPService(url);
				service.url 		= url;
				
				service.addEventListener(FaultEvent.FAULT,onFault);
				service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SplitClaimTransaction(claimTransactionIds:String, claimId:int, managedByUserId:int ):void
		{			
			
			service.showBusyCursor = true;
			service.url = service.url + "/" + claimTransactionIds + "/" + claimId + "/" + managedByUserId;
			service.resultFormat = "e4x";
			service.send();				
			trace( "SplitClaimTransactionDelegate", service.url );		
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