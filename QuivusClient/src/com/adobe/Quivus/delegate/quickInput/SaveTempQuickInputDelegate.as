package com.adobe.Quivus.delegate.quickInput
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.QuickInputDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	
	public class SaveTempQuickInputDelegate extends BaseDelegate
	{
		private var command : IResponder;
		//private var service : Object;
		private var ser			:HTTPService;
	
		public function SaveTempQuickInputDelegate(  command : IResponder )
		{		
			//this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;
			
			ser = new HTTPService(url);
			ser.contentType = "application/json; charset=utf-8";
			ser.method = "POST";
			var url:String = Constants.RESTFUL_SERVICE_BASE_URL + "SaveTempQI" ;
			ser.url = url;
			ser.useProxy = false;	
			
		}
		
		public function SaveTempQuickInput(quickInputDTO:QuickInputDTO, fileName:String, session:UserSessionDTO ) : void {
			//var token:AsyncToken = (service ).SaveTempQI(quickInputDTO, fileName, session);			
			//token.addResponder( command );
			
			
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);			
			
			ser.url = ser.url + "/" + fileName + "/" + session.SessionID;
			
			
			ser.send(JSON_Zig.encode(quickInputDTO));
			
			
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