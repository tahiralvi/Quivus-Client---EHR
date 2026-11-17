package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	public class LoadInsurancesDelegate
	{
		public var responder:Responder;
		public var service:HTTPService;
		public var url:String;
		
		public function LoadInsurancesDelegate(responder:Responder)
		{
			this.responder			= responder;
			url						= BillingConstants.USER_RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_BILLING_INSURANCE;
			service 			 	= new HTTPService(url) ;
			service.addEventListener(ResultEvent.RESULT	,onResult);
			service.addEventListener(FaultEvent.FAULT	,onFault);
		}
		
		public function LoadInsurance(pageNumber:int):void
		{
			service.url				= url + '/' + pageNumber;
			service.resultFormat 	="e4x";
			service.send();
			
		}
		public function onResult(successEvent:ResultEvent):void
		{
			responder.result(successEvent);
		}
		public function onFault(faultEvent:FaultEvent):void
		{
			responder.result(faultEvent);	
		}
	}
}