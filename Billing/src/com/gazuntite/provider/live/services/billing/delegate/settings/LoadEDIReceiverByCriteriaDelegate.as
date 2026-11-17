package com.gazuntite.provider.live.services.billing.delegate.settings
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	

	public class LoadEDIReceiverByCriteriaDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadEDIReceiverByCriteriaDelegate(responder:IResponder)
		{
			this.responder = responder;
			
			var url:String 		= BillingConstants.USER_RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_EDI_RECEIVER_BY_CRITERIA;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchEDIReceiverList(type:int, searchString:String, pageNo:int ):void
		{
			
			service.showBusyCursor = true;
			service.url = service.url + "/" + type+ "/" + searchString+ "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			//logger.debug( "LoadEDIReceiverByCriteriaDelegate -- > service.url:<br>" + service.url );
			trace( "LoadEDIReceiverByCriteriaDelegate", service.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//logger.debug( "LoadEDIReceiverByCriteriaDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}
	}
}