package com.gazuntite.provider.live.services.elab.delegate
{
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.provider.live.services.elab.util.ELabsServiceMethods;
	
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.events.Request;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ProcessLabOrderByCriteriaDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.elab.delegate.ProcessLabOrderByCriteriaDelegate");
		
		public function ProcessLabOrderByCriteriaDelegate(responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.PROCESS_LAB_ORDER_BY_CRITERIA;
			service 			= new HTTPService(url);
			service.url 		= url;
			service.resultFormat = "e4x";
			
			logger.debug( "service.url", url );
			
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public function ProcessLabOrderByCriteria(criteria:String):void
		{
			service.url += "/" + criteria;
			
			logger.debug( "service.url", service.url );
			service.send();
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