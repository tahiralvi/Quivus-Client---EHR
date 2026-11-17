package com.gazuntite.provider.live.services.administration.delegate.accessRightManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class LoadUserGroupedByTypesDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function LoadUserGroupedByTypesDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_CLINICAL_USERS_GROUPED_BY_TYPES;
			service 			= new HTTPService(url);
			service.url 		= url;
			
		}
		
		public function LoadUserGroupedByTypes(clinicBranchId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url + "/" + clinicBranchId;
			
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