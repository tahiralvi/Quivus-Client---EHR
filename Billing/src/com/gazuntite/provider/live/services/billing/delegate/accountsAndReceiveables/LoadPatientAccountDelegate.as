package com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadPatientAccountDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadPatientAccountDelegate(responder:IResponder)
		{
			this.responder 		= responder;			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_PATIENT_ACCOUNT;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchPatientAccount(patientId:int, clinicBranchId:int ):void
		{			
			service.showBusyCursor = true;
			service.url = service.url + "/" + patientId+ "/" + clinicBranchId;
			service.resultFormat = "e4x";
			service.send();	
			//logger.debug( "LoadPatientAccountDelegate -- > service.url:<br>" + service.url );
			trace( "LoadPatientAccountDelegate", service.url );	
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