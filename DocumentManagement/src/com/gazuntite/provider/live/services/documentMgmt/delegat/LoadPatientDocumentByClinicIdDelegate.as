package com.gazuntite.provider.live.services.documentMgmt.delegat
{
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadPatientDocumentByClinicIdDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function LoadPatientDocumentByClinicIdDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.LOAD_PATIENT_DOCUMENT_BY_CLINIC_ID;
			ser = new HTTPService(url);
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function LoadPatientDocumentByClinicId(clinicBranchID:int, pageNo:int):void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
			
			ser.url = ser.url+"/"+clinicBranchID+"/"+pageNo;
			
			ser.send();	
			trace( ser.url );
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