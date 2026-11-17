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

	public class ChangeClaimStatusDelegate
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.ChangeClaimStatusDelegate");
		
		public function ChangeClaimStatusDelegate(responder	:IResponder)
		{
			this.responder 		= responder;
			var url:String;			
			url 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.CHANGE_CLAIM_STATUS;
			
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
		public function ChangeClaimStatus(IDsXml:XML, statusTypeIdFrom:int, statusTypeIdTo:int, mediaTypeIdFrom:int, mediaTypeIdTo:int, insuranceTypeId:int, managedByUserId:int ):void
		{	
			service.url = service.url + "/" + statusTypeIdFrom + "/" + statusTypeIdTo + "/" + mediaTypeIdFrom + "/" + mediaTypeIdTo + "/" + insuranceTypeId + "/" + managedByUserId;
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( IDsXml );	
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