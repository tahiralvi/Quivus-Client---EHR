package com.gazuntite.provider.live.services.elab.delegate
{
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.provider.live.services.elab.util.ELabsServiceMethods;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class SearchLabsByClinicDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.elab.delegate.LoadeLabsStaticDataDelegate");
		
		public function SearchLabsByClinicDelegate(responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= ELabsConstant.RESTFULL_SERVICE_BASE_URL ;
			service 			= new HTTPService(url);
			service.url 		= url;

			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SearchOrders(clinicBranchID:int, pageNo:int, searchText:String, fieldID:int, providerId:int, userTypeId:int):void
		{
			if(searchText.indexOf('/',0))
			{
				searchText = searchText.replace('/','-');
				if(searchText.indexOf('/',0))
					searchText = searchText.replace('/','-');
			}
			service.url = ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.SEARCH_LAB_ORDER + "/" + clinicBranchID + "/" + pageNo + "/" + searchText + "/" + fieldID + "/" + providerId + "/" + userTypeId;
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "service.url", service.url );
		}
		
		public function SearchResults(clinicBranchID:int, pageNo:int, searchText:String, fieldID:int, providerId:int, userTypeId:int):void
		{
			if(searchText.indexOf('/',0))
			{
				searchText = searchText.replace('/','-');
				if(searchText.indexOf('/',0))
					searchText = searchText.replace('/','-');
			}
			service.url = ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.SEARCH_LAB_RESULT + "/" + clinicBranchID + "/" + pageNo + "/" + searchText + "/" + fieldID + "/" + providerId + "/" + userTypeId;
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "service.url", service.url );
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