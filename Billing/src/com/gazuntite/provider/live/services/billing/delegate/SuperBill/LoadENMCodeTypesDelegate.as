package com.gazuntite.provider.live.services.billing.delegate.SuperBill
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadENMCodeTypesDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadENMCodeTypesDelegate(responder	:IResponder)
		{
			this.responder 		= responder;
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_ENM_CODE_TYPES;			
			service 			= new HTTPService(url);
			service.url 		= url;	
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		public function ENMCodeTypeList():void
		{
			
			service.showBusyCursor = true;
			service.url = service.url ;
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "LoadENMCodeTypesDelegate", service.url );
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