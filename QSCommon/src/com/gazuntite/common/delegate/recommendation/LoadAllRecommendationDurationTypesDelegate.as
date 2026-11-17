package com.gazuntite.common.delegate.recommendation
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAllRecommendationDurationTypesDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadAllRecommendationDurationTypesDelegate(responder:IResponder)
		{
			this.responder = responder;
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_ALL_DURATION_TYPES;			
			service = new HTTPService(url);
			service.url = url;	
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadRecommendationDurationType(sessionID:String):void
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