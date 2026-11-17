package com.gazuntite.common.delegate.followUp
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadFollowUpServiceTypeDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadFollowUpServiceTypeDelegate(responder:IResponder)
		{
			this.responder = responder;
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.LOAD_FOLLOWUP_SERVICE_TYPE ;			
			service = new HTTPService(url);
			service.url = url;	
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadServiceType(LoggedInUserSessionID:String, followupDataControlTypeID:int ,LoggedInUserSelectedBranchId:int, searchTerm:String):void
		{
			searchTerm = UtilityFunctions.getEncodedBase64String(searchTerm);
			service.showBusyCursor = true;
			service.url = service.url + "/" + LoggedInUserSessionID + "/" + followupDataControlTypeID + "/" + LoggedInUserSelectedBranchId + "/" + searchTerm;
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