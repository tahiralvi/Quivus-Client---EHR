package com.gazuntite.common.delegate.ccHpi
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAllHPIDetailTypesDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadAllHPIDetailTypesDelegate(  responder : IResponder )
		{		
			this.service =  new HTTPService();
			this.responder = responder;	
			
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.HPI_LOAD_DETAIL_TYPES;
			service = new HTTPService(url);
			service.url = url;
			service.resultFormat = "e4x";
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadAllHPIDetailTypes(sessionID:String):void 
		{
			service.url  = service.url + "/" + sessionID;
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