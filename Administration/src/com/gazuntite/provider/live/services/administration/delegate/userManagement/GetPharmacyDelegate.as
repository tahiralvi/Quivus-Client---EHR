package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import com.gazuntite.provider.search.services.provider.util.PSConstants;
	import com.gazuntite.provider.search.services.provider.util.PSServiceMethods;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GetPharmacyDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		//private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.communication.GetClinicUserDetailsDelegate");//new LogLogger("com.zigron.provider.live.services.elab.delegate.LoadPatientLabsByClinicIdDelegate");
		
		public function GetPharmacyDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			//var url:String 		= "http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/SearchPharmacies/";
			
			//var url:String 		= EConstants.RESTFULL_SERVICE_BASE_URL + "SearchPharmacies/";
			var url:String 		= 'http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/' + "SearchPharmacies/";
			
			service 			= new HTTPService(url);
			service.url 		= url;
			
		}
		
		//public function GetPharmacies(userID:int,clinicBranchId:int):void
		public function GetPharmacies(pageNo:int=0, NPCID:String="0", name:String="0", address:String="0", zipcode:String="0", state:String="0", city:String="0", servicelevel:int=0, phone:String="0", status:String="0"):void
		{
						
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.showBusyCursor = true;
			//service.url = service.url + "/" + userID +"/" + clinicBranchId;// + "/" + pageNo;
			service.url = service.url +pageNo + "/" + NPCID +"/" + name + "/" + address + "/" + zipcode +"/" + state + "/" + city + "/" + servicelevel +"/" + phone + "/" + status ;
			service.resultFormat = "e4x";
			//service.resultFormat = "object";
			service.send();	
			//logger.debug( "getPharmacies -- > service.url:<br>" + service.url );
			trace( service.url );
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//logger.debug( "getPharmacies-- > result for call:<br>" + service.url + "<br> " + event.result);
			//trace( "getPharmacies-- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}	
	}
}