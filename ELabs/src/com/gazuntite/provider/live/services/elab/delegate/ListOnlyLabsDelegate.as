package com.gazuntite.provider.live.services.elab.delegate
{
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.provider.live.services.elab.util.ELabsServiceMethods;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ListOnlyLabsDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.elab.delegate.ListOnlyLabsDelegate");
		
		public function ListOnlyLabsDelegate(responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= ELabsConstant.RESTFULL_SERVICE_BASE_URL ;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function ListOnlyOrders(clinicBranchID:int, pageNo:int, query:String):void
		{
			service.url = ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.LIST_ONLY_LAB_ORDER + "/" + clinicBranchID + "/" + pageNo + "/" + query;
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "service.url", service.url );
		}
		
		public function ListOnlyResults(clinicBranchID:int, pageNo:int, query:String):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.LIST_ONLY_LAB_RESULT + "/" + clinicBranchID + "/" + pageNo + "/" + query;
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "service.url", service.url );
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