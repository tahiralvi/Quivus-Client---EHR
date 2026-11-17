package com.gazuntite.patient.visit.delegate
{
	import com.adobe.cairngorm.business.Responder;
	import com.gazuntite.patient.visit.utlis.VBConstants;
	import com.gazuntite.patient.visit.utlis.VBServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadPatientImmunizationsByPatientIdDelegate
	{
		private var responder:IResponder;
		private var service:HTTPService;
		
		public function LoadPatientImmunizationsByPatientIdDelegate(responder:IResponder)
		{
			this.responder = responder;
			
			var url:String = VBConstants.RESTFUL_SERVICE_BASE_URL + VBServiceMethods.LOAD_PATIENT_IMMUNIZATIONS_BY_PATIENT_ID;
			
			service = new HTTPService(url);
			service.contentType = "application/xml";
			service.url = url;
			
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
		}
		
		public function loadPatientImmunizationByPatientId(xml2Send:XML, patientID:int, loggedInUserProviderID:int, loggedInUserTypeID:int, clinicBranchID:int, loggedInUserSessionID:String, isAllStationSelected:Boolean):void
		{
			service.showBusyCursor = true;
			service.url = service.url + "/" + patientID + "/" + loggedInUserProviderID + "/" + loggedInUserTypeID + "/" + clinicBranchID + "/" + loggedInUserSessionID + "/" + isAllStationSelected;
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