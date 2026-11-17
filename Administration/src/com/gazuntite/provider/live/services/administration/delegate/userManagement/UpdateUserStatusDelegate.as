package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class UpdateUserStatusDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function UpdateUserStatusDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.SECURITY_SERVICE_BASE_URL + AdminServiceMethod.UPDATE_USERS_TATUS;
			service 			= new HTTPService(url);
			service.url 		= url;
			
		}
		
		public function UpdateUserStatus(userID:int, action:String, actionValue:String):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url 		= service.url + "/" + userID + "/" + action + "/" +  actionValue;
				
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