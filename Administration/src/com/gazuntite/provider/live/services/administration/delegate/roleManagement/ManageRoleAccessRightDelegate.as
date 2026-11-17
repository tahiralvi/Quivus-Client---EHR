package com.gazuntite.provider.live.services.administration.delegate.roleManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class ManageRoleAccessRightDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function ManageRoleAccessRightDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.SECURITY_SERVICE_BASE_URL + AdminServiceMethod.MANAGE_ROLE_ACCESS_RIGHT;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
		}
		
		public function ManageRoleAccessRight(xml:XML , userTypeId:int, clinicBranchId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url + "/" + userTypeId + "/" + clinicBranchId;
			
			//service.resultFormat = "e4x";
			service.send(xml);	
			
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