package com.gazuntite.provider.live.services.billing.delegate.ClaimManagement
{
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ManageClaimCarrierDelegate
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.ManageClaimCarrierDelegate");
		
		public function ManageClaimCarrierDelegate(responder:IResponder)
		{
			var url:String;
			this.responder 		= responder;
			url 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.MANAGE_CLAIM_INSURANCE;
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function ManageClaimCarrier(claimCarrierXml:XML,claimNote:String = "0", saveCarriers:String = "true" ):void
		{	
			service.url = service.url + "/" + claimNote + "/" + saveCarriers; 
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( claimCarrierXml );	
			trace( service.url );			
			
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