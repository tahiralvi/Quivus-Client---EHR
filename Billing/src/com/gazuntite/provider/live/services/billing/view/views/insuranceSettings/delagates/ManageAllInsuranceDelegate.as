package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ManageAllInsuranceDelegate
	{
		public var responder	:	IResponder 	;
		public var service		: 	HTTPService  ;
		public var url			:	String		;
		
		public function ManageAllInsuranceDelegate(responder:IResponder)
		{
			this.responder		= responder ;
			url					= BillingConstants.USER_RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.MANAGE_INSURANCE_ORGANIZATION;
			service				= new HTTPService(this.url) ;
			service.contentType	= 'application/xml';
		}
		
		public function SaveInsurance(xmlData:XML):void
		{
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.url		= url   ;
			service.resultFormat = "e4x" ;
			service.send(xmlData);
			
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