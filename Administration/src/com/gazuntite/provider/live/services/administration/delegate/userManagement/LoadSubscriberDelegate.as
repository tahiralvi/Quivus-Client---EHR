package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LoadSubscriberDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
	//	private var logger:ILogger = Log.getLogger("com.zigron.provider.search.services.patient.delegate.SubscribePatientDelegate");

		public function LoadSubscriberDelegate( responder : IResponder )
		{
			this.responder 		= responder;
		//	var url:String 		= "http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/LoadPrescriberbyGaxenID/";
			
		//	var url:String 		= EConstants.RESTFULL_SERVICE_BASE_URL + "LoadPrescriberbyGaxenID/";
			var url:String 		= 'http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/' + "LoadPrescriberbyGaxenID/";
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
			//logger.debug( "service.url", url );
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
	
		public function LoadPrescriber(data:XML, gaxenId:String, date:Date):void
		{
			trace("LoadPrescriber");
			trace("LoadPrescriber XML before passing to service", data.toXMLString());
			
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
			//service.url += "/" + d;
			
			trace("GGGAXEN ID "+gaxenId);
			
		//	logger.debug( "service.url", service.url );
			
			service.url = service.url + gaxenId; 
			
			
			service.send(data);
		}
		
	
		/*
		public function SearchPatientList(clinicBranchId:int, providerId:int, userTypeId:int, searchString:String, demandPageNo:int ):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.showBusyCursor = true;
			service.url = service.url + "/" + clinicBranchId + "/" + providerId + "/" + userTypeId + "/" + searchString + "/" + demandPageNo;//"/" + clinicBranchID + "/" + pageNo;
			service.resultFormat = "e4x";
			service.send();	
			logger.debug( "SubscribePatientDelegate -- > service.url:<br>" + service.url );
			trace( service.url );
		}*/
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			trace("LoadSubscriberDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
		
			//trace(event.message.toString());
			//logger.debug( "SubscribePatientDelegate -- > result for call:<br>" + service.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			trace("LoadSubscriberDelegate -- > fault for call:<br>" + service.url + "<br> " + event.fault);
		}
		
		
	}
}