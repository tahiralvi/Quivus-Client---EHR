package com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class LoadPatientStatementDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadPatientStatementDelegate(responder:IResponder)
		{
			this.responder 		= responder;			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_PATIENT_STATEMENT;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchStatementList(searchType:int,searchString:String, clinicBranchId:int,pageNo:int ):void
		{			
			service.showBusyCursor = true;
			service.url = service.url + "/" + searchType+ "/" + searchString + "/" + clinicBranchId + "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "LoadPatientStatementDelegate", service.url );	
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