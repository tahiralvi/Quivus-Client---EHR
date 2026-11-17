package com.gazuntite.provider.live.services.administration.delegate.roleManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class LoadRoleAccessRightDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function LoadRoleAccessRightDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_ROLE_ACCESS_RIGHT;
		//	var url:String 		= '/config/Role.xml'+'?r=' + Math.random();
			service 			= new HTTPService(url);
	//		service 			= new HTTPService();
			service.url 		= url;
			
		}
		
		public function LoadRoleAccessRight(userTypeId:int, clinicBranchId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url + "/" + userTypeId + "/" + clinicBranchId;
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