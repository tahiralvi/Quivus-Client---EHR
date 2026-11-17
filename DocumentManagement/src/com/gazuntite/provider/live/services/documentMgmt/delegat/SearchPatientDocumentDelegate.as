package com.gazuntite.provider.live.services.documentMgmt.delegat
{
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SearchPatientDocumentDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function SearchPatientDocumentDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.SEARCH_PATIENT_DOCUMENT;
			ser = new HTTPService(url);
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function SearchPatientDocument(clinicBranchId:int, key:int, value:String,pageNo:int):void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			if(value!=null && value.length>0)
			{				
				var i:int;
				for(i=0;i<value.length;i++)
				{
					if(value.search("/")>-1)
					{
						value = value.replace( "/", "-" );
					}
					
				}
			}
			ser.url = ser.url+"/"+clinicBranchId+"/"+value+"/"+key+"/"+pageNo;
			
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