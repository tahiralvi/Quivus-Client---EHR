package com.gazuntite.provider.live.services.billing.delegate
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAllClaimbyProviderIdDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		//private var logger:ILogger = Log.getLogger("com.zigron.provider.live.services.billing.delegate.LoadAllClaimbyProviderIdDelegate");
		
		public function LoadAllClaimbyProviderIdDelegate( responder : IResponder )
		{			
			this.responder 		= responder;			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_ALL_CLAIM_BY_PROVIDER_ID;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchClaimList(providerId:int, clinicBranchId:int, pageNo:int ):void
		{
			
			service.showBusyCursor = true;
			service.url = service.url + "/" + providerId+ "/" + clinicBranchId+ "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			//logger.debug( "LoadAllClaimbyProviderId -- > service.url:<br>" + service.url );
			trace( "LoadAllClaimbyProviderIdDelegate", service.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//logger.debug( "LoadAllClaimbyProviderId -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}
		
		
	}
}