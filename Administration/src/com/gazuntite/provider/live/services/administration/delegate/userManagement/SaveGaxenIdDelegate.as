package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SaveGaxenIdDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		
		public function SaveGaxenIdDelegate( responder : IResponder )
		{
			this.responder 		= responder;
		//	var url:String 		= "http://www.quivus.com/quivusairdev/QuivusMainManagerService/QuivusManagerProviderSearchRestfullService/QuivusManagerProviderSearchRestfullService.svc/UpdateGaxenID/";
		//	var url:String 		= EConstants.RESTFULL_PROVIDER_SERVICE_BASE_URL + "UpdateGaxenID/";
			var url:String 		= 'http://www.quivus.com/quivusairdev/QuivusMainManagerService/QuivusManagerProviderSearchRestfullService/QuivusManagerProviderSearchRestfullService.svc/' + "UpdateGaxenID/";
			service 			= new HTTPService(url);
			service.url 		= url;
			
			//service.contentType = "Text/Xml";
			service.method		= "GET";
			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
	
		public function SaveGaxenId(userId:String, gaxenId:String, date:Date):void
		{
			trace("delegate >> Save Gaxen ID");			
			
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
	
			
			service.url = service.url +gaxenId + "/" + userId ;
			service.resultFormat = "e4x";
			service.send();	

		}
			
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			trace("SaveGaxenIdDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
		
			trace(event.message.toString());
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			trace("SaveGaxenIdDelegate -- > fault for call:<br>" + service.url + "<br> " + event.fault);
		}
		
		
	}
}