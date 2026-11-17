package com.gazuntite.provider.live.services.documentMgmt.delegat.staticData
{
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.BaseDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	public class LoadDocumentSectionTypeStaticDataDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function LoadDocumentSectionTypeStaticDataDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.LOAD_DOCUMENT_SECTION_TYPES;
			ser = new HTTPService(url);
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function LoadDocumentSectionTypeStaticData():void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
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