package com.gazuntite.provider.live.services.elab.delegate
{
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.provider.live.services.elab.util.ELabsServiceMethods;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadPatientLabOdersByClinicIdDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.zigron.provider.live.services.elab.delegate.LoadPatientLabsByClinicIdDelegate");//new LogLogger("com.zigron.provider.live.services.elab.delegate.LoadPatientLabsByClinicIdDelegate");
		
		public function LoadPatientLabOdersByClinicIdDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			var url:String 		= ELabsConstant.RESTFULL_SERVICE_BASE_URL + ELabsServiceMethods.LOAD_PATIENT_LABS_ORDERS_BY_CLINIC_ID;
			service 			= new HTTPService(url);
			service.url 		= url;
			
			logger.debug( "service.url", url );

			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function LoadPatientLabOdersByClinicId(clinicBranchID:int, pageNo:int):void
		{
			
			service.url = service.url + "/" + clinicBranchID + "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			trace( service.url );
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