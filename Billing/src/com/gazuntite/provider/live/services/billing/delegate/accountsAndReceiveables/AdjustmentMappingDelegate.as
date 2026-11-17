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

	public class AdjustmentMappingDelegate
	{
				
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.AdjustmentMappingDelegate");
		
		public function AdjustmentMappingDelegate(responder:IResponder)
		{
			this.responder  =  responder;
			var url:String  =  BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.LOAD_ADJUSTMENT_MAPPING;
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function LoadAdjustmentMapping( ):void
		{	
			service.showBusyCursor = true;				
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "AdjustmentMappingDelegate -- > service.url:<br>" + service.url );
			trace( "AdjustmentMappingDelegate ", service.url );				
		}
		
		public function ManageAdjustmentMapping(xmlDocument:XML ):void
		{	
			service.url = BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.MANAGE_ADJUSTMENT_MAPPING; 
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( xmlDocument );	
			trace("AdjustmentMappingDelegate ", service.url );			
			
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