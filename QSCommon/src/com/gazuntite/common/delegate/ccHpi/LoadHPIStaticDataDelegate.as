package com.gazuntite.common.delegate.ccHpi
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadHPIStaticDataDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function LoadHPIStaticDataDelegate(responder:IResponder)
		{		
			this.service =  new HTTPService();
			this.responder = responder;	
			
			var url:String = QSConstants.RESTFUL_SERVICE_BASE_URL + QSCommonServiceMethods.HPI_LOAD_STATIC_DATA;
			service = new HTTPService(url);
			service.url = url;
			service.method = URLRequestMethod.GET;
			service.resultFormat = "e4x";
			
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public function loadHPIStaticData(hpiId:int, clinicBranchId:int, sessionID:String, searchString:String):void 
		{
			//LoadHPIDetailAutoCompleteByTypeIdAndClinicId/{hpiTypeId}/{clinicBranchId}/{searchCriteria}/{sessionID} 
			if( searchString == "")
			{
				service.url  = service.url + "/" + hpiId + "/" + clinicBranchId + "/\"\"/" + sessionID;
			}
			else
			{
				service.url  = service.url + "/" + hpiId + "/" + clinicBranchId + "/" + searchString  + "/" + sessionID;
			}
			
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