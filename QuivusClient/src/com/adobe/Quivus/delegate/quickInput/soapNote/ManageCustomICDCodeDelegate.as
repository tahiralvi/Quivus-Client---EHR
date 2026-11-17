package com.adobe.Quivus.delegate.quickInput.soapNote
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.utils.Constants;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.ICDCodeDTO;
	
	
	public class ManageCustomICDCodeDelegate extends BaseDelegate
	{
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.quickInput.soapNote.ManageCustomICDCodeDelegate");
		
		private var responder	:IResponder;
		private var RestfulService : HTTPService;
		
		public function ManageCustomICDCodeDelegate(command : IResponder)
		{
			this.responder = command;
			
			var url:String 				= Constants.RESTFUL_SERVICE_BASE_URL + "ManageCustomICDCode/" ;
			RestfulService 				= new HTTPService(url);
			RestfulService.contentType 	= "application/json; charset=utf-8";
			RestfulService.method = "POST";
			RestfulService.addEventListener(FaultEvent.FAULT, onFault);
			RestfulService.addEventListener(ResultEvent.RESULT, onResult);
			
		}
		public function ManageCustomICDCode(icdCodeDTO:ICDCodeDTO, userID:String, sessionID:String):void
		{
			RestfulService.url = Constants.RESTFUL_SERVICE_BASE_URL + "ManageCustomICDCode/" + userID + "/" + sessionID;  
			var json:String = JSON_Zig.encode(icdCodeDTO);
			
			logger.debug( "RestfulService.url: " + RestfulService.url );
			logger.debug( "json: " + json );
			
			RestfulService.send(json);	
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