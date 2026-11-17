package com.gazuntite.common.delegate.immunization
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadImmunizationStaticDataDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadImmunizationStaticDataDelegate(responder:IResponder)
		{
			this.responder = responder;
			
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_IMMUNICATION_STATIC_DATA;			
			
			service = new HTTPService(url);
			service.url = url;	
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function LoadImmunizationStaticData(searchCritera:String, clinicBranchID:int, subSectionName:String, sessionID:String):void
		{
			service.showBusyCursor = true;
			//LoadImmunicationStaticData/{searchCritera}/{clinicBranchID}/{subSectionName}/{userSessionID}
			service.url = service.url + "/" + searchCritera + "/" + clinicBranchID + "/" + subSectionName + "/" + sessionID;
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