package com.gazuntite.provider.live.services.documentMgmt.delegat
{
	import com.zigron.serialization.json.*;
	import com.gazuntite.common.dto.PatientDocumentDTO;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMRServiceMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ManagePatientDocumentDelegate extends BaseDelegate
	{
		private var responder	:IResponder;
		private var ser			:HTTPService;
	
		public function ManagePatientDocumentDelegate(  command : IResponder )
		{		
			this.responder    = command;
			var url:String = DMConstant.RESTFULL_SERVICE_BASE_URL + DMRServiceMethod.MANAGE_PATIENT_DOCUMENTS;
			
			ser = new HTTPService(url);
			ser.contentType = "application/json; charset=utf-8";
			ser.method = "POST";
			ser.url = url;
			ser.useProxy = false;			
		}
		
		public function ManagePatientDocument(pdDTO:PatientDocumentDTO):void
		{
			ser.addEventListener(FaultEvent.FAULT,onFault);
			ser.addEventListener(ResultEvent.RESULT,onResult);
							
			
			ser.send(JSON_Zig.encode(pdDTO));	
			
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