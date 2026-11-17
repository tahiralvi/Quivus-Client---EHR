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
	
	public class LoadClinicGeneralSettingMainDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var ser			:HTTPService;
	
		public function LoadClinicGeneralSettingMainDelegate(  command : IResponder )
		{		
			this.command    = command;
			
			var url:String = Constants.QUIVUS_SECURITY_SERVICE_BASE_URL + "LoadClinicGeneralSetting" ;
			ser = new HTTPService(url);
			ser.url = url;
		}
		
		public function LoadGeneralSetting(clinicBrachId:int) : void {
			
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
			ser.url = ser.url + "/" + clinicBrachId;
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