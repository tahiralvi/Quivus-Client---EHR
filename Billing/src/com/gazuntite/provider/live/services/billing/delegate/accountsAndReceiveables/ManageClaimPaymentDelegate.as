package com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables
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

	public class ManageClaimPaymentDelegate
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.ManageClaimPaymentDelegate");
		
		public function ManageClaimPaymentDelegate(responder:IResponder)
		{
			this.responder  =  responder;
			var url:String  =  BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.MANAGE_CLAIM_PAYMENTS;
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function ManageclaimPayment(xmlDocument:XML ):void
		{	
			//service.url = service.url + "/" + parameter; 
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( xmlDocument );	
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