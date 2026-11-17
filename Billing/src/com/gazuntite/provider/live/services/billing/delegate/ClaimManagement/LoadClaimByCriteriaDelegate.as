package com.gazuntite.provider.live.services.billing.delegate.ClaimManagement
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadClaimByCriteriaDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadClaimByCriteriaDelegate(responder:IResponder)
		{
			this.responder 		= responder;			
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_CLAIM_BY_SEARCH_CRITERIA;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchClaimList(searchDetail:XML ):void
		{			
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( searchDetail );	
			trace( service.url );	
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