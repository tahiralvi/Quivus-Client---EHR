package com.gazuntite.provider.live.services.administration.delegate.generalSetting
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public class LoadGeneralSettingDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function LoadGeneralSettingDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL + AdminServiceMethod.LOAD_CLINIC_BRANCH_GENERAL_SETTING;
			service 			= new HTTPService(url);
			service.url 		= url;
		}
		
		public function LoadGeneralSetting(cbId:int):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url 		= service.url + "/" +cbId ;
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