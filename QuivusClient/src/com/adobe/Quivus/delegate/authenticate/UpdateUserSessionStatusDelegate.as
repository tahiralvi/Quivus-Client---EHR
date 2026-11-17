package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.UserSessionDTO;
	
	public class UpdateUserSessionStatusDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.authenticate.UpdateUserSessionStatusDelegate");
		
		private var RestfulService : HTTPService;
		
		public function UpdateUserSessionStatusDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;		
			
			
			//for rest Service Test
			var url:String 				= Constants.RESTFUL_SERVICE_BASE_URL + "GenerateSoapNoteByVisitID/" ;
			RestfulService 				= new HTTPService(url);
			RestfulService.contentType 	= "application/json; charset=utf-8";
			RestfulService.method = "POST";
			RestfulService.addEventListener(FaultEvent.FAULT, onFault);
			RestfulService.addEventListener(ResultEvent.RESULT, onResult);
			
			
			
		}
		
		public function UpdateUserSession(sessionDTO : UserSessionDTO) : void {
			var token:AsyncToken = (service ).updateUserSessionStatusID(sessionDTO);			
			token.addResponder( command );
		}
		
		public function UpdateUserSessionRestService(sessionDTO : UserSessionDTO) : void 
		{
			RestfulService.url = Constants.RESTFUL_SERVICE_BASE_URL + "updateUserSessionStatusID";
			var json:String = JSON_Zig.encode(sessionDTO);
			
			logger.debug( "RestfulService.url: " + RestfulService.url );
			logger.debug( "json: " + json );
			
			RestfulService.send(json);	
		}
		
		private function onResult(event:ResultEvent):void
		{
			command.result(event);
		}
		
		private function onFault(event:FaultEvent):void
		{
			command.fault(event);			
		}
		
		
	}
}