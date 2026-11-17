package com.gazuntite.provider.live.services.administration.delegate.generalSetting
{
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.provider.live.services.administration.util.AdminServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectProxy;
	
	
	public class ManageGeneralSettingDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function ManageGeneralSettingDelegate(responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= AdminConstant.QUIVUS_SECURITY_SERVICE_BASE_URL + AdminServiceMethod.MANAGE_GENERAL_SETTING;
			service 			= new HTTPService(url);
			service.url 		= url;
			service.contentType = "Text/Xml";
			service.method		= "POST";
		}
		
		public function ManageGeneralSetting(xml:XML):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
			service.url 		= service.url;
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