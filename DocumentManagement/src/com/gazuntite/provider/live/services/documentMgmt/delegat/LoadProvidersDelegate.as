package com.gazuntite.provider.live.services.documentMgmt.delegat
{
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadProvidersDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function LoadProvidersDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.LOAD_PROVIDERS;
			ser = new HTTPService(url);
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function LoadProviders(clinicBranchId:int):void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			ser.url = ser.url + "/" + clinicBranchId;
			ser.send();		
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