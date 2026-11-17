package com.gazuntite.provider.live.services.billing.delegate.report
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ERAClaimDetailReportDelegate
	{		
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function ERAClaimDetailReportDelegate(responder : IResponder)
		{
			this.responder = responder;
			var url:String 		= "http://localhost:49431/BillingService.svc/ERAClaimDetailReport";			
			//var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.ERA_CLAIM_DETAIL_REPORT;			
			service 			= new HTTPService(url);
			service.url 		= url;	
			service.method 		= "POST";
			service.contentType = 'text/xml';
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);		
		}
		
		public function GeneratePreview(ERAClaimDetailXML:XML):void
		{			
			service.resultFormat = "e4x";
			service.send(ERAClaimDetailXML);
			
			trace(ERAClaimDetailXML);
			trace( "ERAClaimDetailReportDelegate", service.url );
			
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