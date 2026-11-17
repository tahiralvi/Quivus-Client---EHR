package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.osmf.logging.Logger;

	public class ManageProviderInsuranceDelegate
	{
		private var responder		:IResponder;
		private var service			:HTTPService;
		
		public function ManageProviderInsuranceDelegate(responder:IResponder)
		{
			this.responder    = responder;
			var url:String    = 'http://www.quivus.com/QuivusAirDev/UserService/Service/RestfulService/UserManagerRestfulService.svc/' + 'ManageProviderInsurance';
			service           = new HTTPService(url);
			service.url 	  = url;
			
			service.addEventListener(FaultEvent.FAULT, onFault);
			service.addEventListener(ResultEvent.RESULT, onResult);			
		}
		
		public function ManageProviderInsurance(xmlData:XML):void
		{
			service.showBusyCursor = true;
			service.resultFormat   = "e4x";
			service.contentType 	= "Text/Xml";
			service.method         = URLRequestMethod.POST;
			service.send(xmlData);
			
			trace( "ManageProviderInsuranceDelegate: ", service.url );
		}
		
		public function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//Logger.debug( "ManageProviderInsuranceDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		public function onFault(event:FaultEvent):void
		{
			responder.fault(event);
			//Logger.debug( "ManageProviderInsuranceDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
	}
}