package com.gazuntite.common.delegate.labs
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadInHouseLabStaticDataDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.common.delegate.labs.LoadInHouseLabStaticDataDelegate");
			
		public function LoadInHouseLabStaticDataDelegate(responder:IResponder)
		{
			this.service = new HTTPService();
			this.responder = responder;	
			
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL  + QSCommonServiceMethods.LOAD_IN_HOUSE_LAB_STATIC_DATA;
			service = new HTTPService(url);
			service.url = url;
			service.method = URLRequestMethod.GET;
			service.resultFormat = "e4x";
			
			logger.debug( "service.url", url );
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadInHouseLabStaticData(searchString:String , clinicBranchId:int , sessionID : String):void
		{
			service.url  = service.url + "/" + searchString + "/" + clinicBranchId + "/" + sessionID ;
			
			trace(service.url);
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
		
		private function onOtherError(event:Event):void
		{
			trace(event);			
		}
	}
}