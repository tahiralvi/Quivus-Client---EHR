package com.adobe.Quivus.delegate.staticData.patientsData
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class LoadCurrentDayAddedPatientsDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
	
		public function LoadCurrentDayAddedPatientsDelegate(  responder : IResponder )
		{		
			this.responder 			= responder;
			var url:String 			= Constants.PATIENT_SEARCH_RESTFULSERVICE + Constants.LOAD_CURRENT_DAY_ADDED_PATIETNS ;
			service 				= new HTTPService(url);
			service.url 			= url;			
		}
		
		public function LoadCurrentDayAddedPatients(clinicBranchId:int ,pageNo:int) : void 
		{
			service.addEventListener(FaultEvent.FAULT, onFault);
			service.addEventListener(ResultEvent.RESULT, onResult);
			
			service.url = service.url +'/'+ clinicBranchId +'/'+ pageNo;
			service.resultFormat = "e4x";
			service.send();	
			
			trace( "LoadCurrentDayAddedPatientsDelegate", service.url );
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