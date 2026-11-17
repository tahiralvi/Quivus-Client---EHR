package com.gazuntite.common.delegate.labs
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadLabTestTypeStaticDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadLabTestTypeStaticDelegate(responder:IResponder)
		{
			this.responder = responder;
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_LAB_OUT_TEST_TYPE;			
			service = new HTTPService(url);
			service.url = url;	
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function laboutTypeList(sessionId:String):void
		{	
			service.showBusyCursor = true;
			service.url = service.url + "/" + sessionId;
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