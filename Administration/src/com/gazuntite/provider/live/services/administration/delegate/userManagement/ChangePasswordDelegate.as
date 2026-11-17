package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.search.services.provider.util.PSConstants;
	import com.gazuntite.provider.search.services.provider.util.PSServiceMethods;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ChangePasswordDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		public function ChangePasswordDelegate( responder : IResponder )
		{
			this.responder 		= responder;
		//	var url:String 		= EConstants.RESTFULL_USER_SERVICE_BASE_URL + "UpdateUserPasswordbyPost";
			var url:String 		= 'http://quivus.com/QuivusAir/UserService/Service/RestfulService/UserManagerRestfulService.svc/' + "UpdateUserPasswordbyPost";
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
		
		/*public function ChangePassword(user_id:String, newpass:String, oldpass:String):void
		{
			service.url 		= service.url + user_id + "/" + newpass + "/" + oldpass;			
			service.send();	
			trace( service.url );
		}*/
		
		public function ChangePassword(data:XML):void
		{
						
			service.send(data);	
			//trace( service.url );
		}
		
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//trace( "ChangePasswordDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
			//trace(event.message.toString());
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}	
	}
}