package com.gazuntite.patient.visit.delegate.diagnosis
{
	import com.gazuntite.patient.visit.utlis.VBConstants;
	import com.gazuntite.patient.visit.utlis.VBServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadChronicDiagnosisByPatientIdPagedDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadChronicDiagnosisByPatientIdPagedDelegate(responder:IResponder)
		{
			this.responder = responder;
			
			var url:String = VBConstants.RESTFUL_SERVICE_BASE_URL + VBServiceMethods.LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED;
			
			service = new HTTPService(url);
			service.contentType = "application/xml";
			service.url = url;
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadChronicDiagnosisByPatientIdPaged(xml2Send:XML, patientID:int, clinicBranchID:int, loggedInUserSessionID:String):void
		{
			service.showBusyCursor = true;
			service.url = service.url + "/" + patientID + "/" + clinicBranchID + "/" + loggedInUserSessionID;
			service.resultFormat = "e4x";
			service.method = URLRequestMethod.POST;
			
			service.send(xml2Send);
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