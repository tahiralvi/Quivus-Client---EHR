package com.gazuntite.common.delegate.labs
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.collections.ItemResponder;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadLabTypeStaticDataDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadLabTypeStaticDataDelegate(responder:IResponder)
		{
			this.responder = responder;
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_LAB_OUT_LAB_TYPE;			
			service = new HTTPService(url);
			service.url = url;	
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function labOutLabTypelist(sessionID:String):void
		{
			service.showBusyCursor = true;
			service.url = service.url + "/" + sessionID;
			service.resultFormat = "e4x";
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