package com.gazuntite.common.delegate.visit
{
	import com.gazuntite.common.util.QSCommonServiceMethods;
	import com.gazuntite.common.util.QSConstants;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class VerifyUserDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function VerifyUserDelegate(responder:IResponder)
		{
			this.service 		=  new HTTPService();
			this.responder 		= responder;	
			
			var url:String 		= QSConstants.EPRESCRIPTION_QM_SERVICE + QSCommonServiceMethods.VERIFY_USER;
			service 			= new HTTPService(url);
			service.url 		= url;
			service.method		= URLRequestMethod.POST;
			service.resultFormat = "e4x";
			service.contentType = "application/xml; charset=utf-8";
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function VerifyUser(LoggedInUserId:int, password:String, LoggedInUserSessionID:String):void
		{
			service.url  = service.url + "/" + LoggedInUserId + "/"  + LoggedInUserSessionID ;
			
			trace(service.url);
			
			service.send("<string>"+password+"</string>");
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