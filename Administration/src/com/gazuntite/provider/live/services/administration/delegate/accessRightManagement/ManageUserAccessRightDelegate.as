package com.gazuntite.provider.live.services.administration.delegate.accessRightManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class ManageUserAccessRightDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function ManageUserAccessRightDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.SECURITY_SERVICE_BASE_URL + AdminServiceMethod.MANAGE_USER_ACCESS_RIGHTS;
			service 			= new HTTPService(url);
			service.url 		= url;
			service.method = "POST";
			service.contentType = "text/xml;";
		}
		
		public function ManageUserAccessRight(xml:XML ,userId:int, clinicBranchId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url = service.url + "/" + userId + "/" + clinicBranchId;
			service.resultFormat = "e4x";
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