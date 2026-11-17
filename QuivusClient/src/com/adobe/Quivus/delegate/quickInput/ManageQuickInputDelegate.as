package com.adobe.Quivus.delegate.quickInput
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.QuickInputDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	
	public class ManageQuickInputDelegate extends BaseDelegate
	{
		private var command : IResponder;
		//private var service : Object;
		private var ser			:HTTPService;
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.quickInput.ManageQuickInputDelegate");
		
		public function ManageQuickInputDelegate(  command : IResponder )
		{		
			//this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			//this.command = command;			
			
			this.command    = command;
			
			var url:String = Constants.RESTFUL_SERVICE_BASE_URL + "ManageQuickInputData" ;
			ser = new HTTPService(url);
			ser.url = url;
			ser.method = "POST";
			ser.contentType = "application/json; charset=utf-8";			
			
		}
		
		public function ManageQuickInput(quickInputDTO:QuickInputDTO,loggedInuserId:int, session:UserSessionDTO ) : void 
		{
			//var token:AsyncToken = (service ).ManageQuickInputData(quickInputDTO, loggedInuserId, session);			
			//var srt:String = JSON.encode(quickInputDTO);
			
			//token.addResponder( command );
			
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
			//var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + "ManageQuickInputData" + "/" + loggedInuserId + "/" + session.SessionID;
			ser.url = ser.url + "/" + loggedInuserId + "/" + session.SessionID;
			
			var json:String = JSON_Zig.encode(quickInputDTO);
			logger.debug( "ManageQuickInput: url: " + ser.url );
			logger.debug( "ManageQuickInput: json: " + json );
			
			ser.send(json);	
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