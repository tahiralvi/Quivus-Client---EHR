package com.adobe.Quivus.delegate.viewBackground.summary
{
	import com.adobe.Quivus.utils.Constants;
	
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.SummaryViewDTO;
	import valueObjects.SummaryViewResponseDTO;


	public class LoadSummaryDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.viewBackground.summary.LoadSummaryDelegate");
		
		public function LoadSummaryDelegate( responder : IResponder )
		{
			this.responder 			= responder;
			var url:String 		= Constants.RESTFUL_SERVICE_BASE_URL + "LoadSummaryView";
			//var url:String			= "http://quivus.com/QuivusAir/TestManagerService/QuivusManagerRestfullService/QuivusManagerRestfullService.svc/LoadSummaryView";
			service 				= new HTTPService(url);
			service.contentType 	= "application/xml; charset=utf-8";
			service.method 			= "POST";
			service.useProxy 		= false;
			service.url 			= url;
			
		}
		
		public function LoadSummary( xml:String ):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.showBusyCursor = true;
			
			service.resultFormat = "e4x";
			
			
			
			service.send( xml );	
			//log Call information if debugging
			if( Log.isDebug() )
			{
				logger.debug( "LoadSummaryDelegate -- > service.url:<br>" + service.url );
				logger.debug( "LoadSummaryDelegate -- >param xml: <br>" + xml );
			}
			trace( service.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			if( Log.isDebug() )
				logger.debug( "LoadSummaryDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);		
			if( Log.isDebug() )
				logger.debug( "LoadSummaryDelegate -- > fault for call:<br>" + service.url + "<br> " + event.toString() + "<br> " + event.fault.getStackTrace());
		}
		
	}
}