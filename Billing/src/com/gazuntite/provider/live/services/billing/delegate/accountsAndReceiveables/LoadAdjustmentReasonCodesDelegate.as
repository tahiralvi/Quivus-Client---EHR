package com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAdjustmentReasonCodesDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadAdjustmentReasonCodesDelegate(responder:IResponder)
			{
				this.responder 		= responder;			
				var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_ADJUSTMENT_REASON_CODES;
				service 			= new HTTPService(url);
				service.url 		= url;
				
				service.addEventListener(FaultEvent.FAULT,onFault);
				service.addEventListener(ResultEvent.RESULT,onResult);
			}
			
			public function GetReasonCodes( ):void
			{			
				service.showBusyCursor = true;				
				service.resultFormat = "e4x";
				service.send();	
				//logger.debug( "LoadPatientAccountDelegate -- > service.url:<br>" + service.url );
				trace( "LoadAdjustmentReasonCodesDelegate", service.url );	
			}
			
			private function onResult(event:ResultEvent):void
			{
				responder.result(event);
				//logger.debug( "LoadPatientAccountDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
			}
			
			private function onFault(event:FaultEvent):void
			{
				responder.fault(event);			
			}
	}
}