package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.delagates
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	

	public class LoadAllInsuranceByIDDelegate
	{ 
		public var responder	:	IResponder 	;
		public var service		: 	HTTPService  ;
		public var url			:	String		;
		
		
		public function LoadAllInsuranceByIDDelegate(responder:IResponder)
		{ 
			this.responder		= responder ;
			url					= BillingConstants.USER_RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_BILLING_INSURANCE_BY_CRITERIA;
			service				= new HTTPService(this.url) ;
			service.method		= 'Get';
			service.contentType	= 'Text';
			
			
		}

		public function SearchInsurance(index:int,searchString:String,pageNumber:int):void
		{
			service.addEventListener(ResultEvent.RESULT,onSuccess);
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.url		= url + '/' + index + '/' + searchString  + '/' + pageNumber  ;
			service.resultFormat = "e4x" ;
			service.send();
				
		}
		private  function onSuccess (successEvent:ResultEvent):void
		{
			responder.result(successEvent);
		}
		private function onFault(faultEvent:FaultEvent):void
		{
			 responder.fault(faultEvent) ;
		}
	}
}