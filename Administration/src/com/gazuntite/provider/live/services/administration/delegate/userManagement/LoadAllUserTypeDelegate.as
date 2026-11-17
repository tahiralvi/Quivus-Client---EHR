package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadAllUserTypeDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadAllUserTypeDelegate( responder : IResponder)
		{
			this.responder 		= responder;
			
			var url:String 		= AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_ALL_USER_TYPE;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.addEventListener(FaultEvent.FAULT, onFault);
			service.addEventListener(ResultEvent.RESULT, onResult);
		}
		
		public function LoadAllUserType():void
		{
			service.url 		= service.url;			
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