package com.gazuntite.common.delegate
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadICDCodeDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadICDCode(icdCode:String, sessionID:String):void
		{
			icdCode = UtilityFunctions.getEncodedBase64String(icdCode);
			service.showBusyCursor = true;
			service.url = service.url + "/" + sessionID + "/" + icdCode;
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "LoadICDCodeDelegate", service.url );
		}
		
		public function LoadICDCodeDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_ICD_CODE;			
			service 			= new HTTPService(url);
			service.url 		= url;	
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
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