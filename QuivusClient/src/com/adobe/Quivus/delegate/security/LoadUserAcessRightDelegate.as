package com.adobe.Quivus.delegate.security
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import services.streamingservice.StreamingService;
	
	public class LoadUserAcessRightDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var ser			:HTTPService;
	
		public function LoadUserAcessRightDelegate(  command : IResponder )
		{		
			this.command    = command;
			
			var url:String = Constants.SECURITY_SERVICE_BASE_URL + "LoadUserAccessRight" ;
			ser = new HTTPService(url);
			ser.url = url;
		}
		
		public function LoadUserAcessRight(userId:int, userTypeID:int , clinicBrachId:int) : void {
			
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
			ser.url = ser.url + "/" + userId + "/" + userTypeID + "/" + clinicBrachId;
			ser.send();	
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