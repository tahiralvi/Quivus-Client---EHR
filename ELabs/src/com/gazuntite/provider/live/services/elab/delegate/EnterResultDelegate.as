package com.gazuntite.provider.live.services.elab.delegate
{
	import com.gazuntite.provider.live.services.elab.dto.LabDTO;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.provider.live.services.elab.util.ELabsServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.events.Request;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class EnterResultDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.elab.delegate.EnterResultDelegate");
		
		public function EnterResultDelegate(responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.ENTER_RESULT;
			service 			= new HTTPService(url);
			service.contentType = "Text/Xml";
			service.resultFormat = "e4x";
			service.method		= URLRequestMethod.GET;
			service.url 		= url;
			
			
			logger.debug( "service.url", url );
			
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public function EnterResult( OrderID:String , ResultRanage:String ):void
		{
			service.url = service.url + "/" + OrderID + "/" + ResultRanage;
			service.send();
			
			if( Log.isDebug() )
			{
				logger.debug( "service.url", service.url );
				logger.debug( "EnterResultDelegate", " OrderID: " + OrderID + " ResultRanage: " + ResultRanage );
			}
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