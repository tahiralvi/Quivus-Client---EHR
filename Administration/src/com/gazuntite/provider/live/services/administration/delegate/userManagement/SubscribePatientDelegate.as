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

	public class SubscribePatientDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
	//	private var logger:ILogger = Log.getLogger("com.zigron.provider.search.services.patient.delegate.SubscribePatientDelegate");
		
		
		public function SubscribePatientDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			//var url:String 		= EConstants.RESTFULL_SERVICE_BASE_URL + EConstants.SUBSCRIBE_PATIENT;
			var url:String 		= 'http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/' + 'SubscribeUser';
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
		//	logger.debug( "service.url", url );
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
	
		public function SubscribePatient(data:XML, updateAdd:String, date:Date):void
		{
			trace("Subscribe patient");
			trace("Subscribe patient XML before passing to service", data.toXMLString());
			
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
			//service.url += "/" + d;
			
			if(updateAdd == "update")
			{
				service.url 		= "http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/UpdateSubscribedUser";
			}
			
			//logger.debug( "service.url", service.url );
			
			/*var data:XML = <Prescriber
									NPI="1234567890"
									FirstName="alamdarrrrr"
									LastName="khan"
									DEANumber="q1212212"
									AddressLine1="adf"
									PhoneNumber="23231232323223"
									FaxNumber="2323213232323"
									City="sadas"
									State="gfdg"
									ZipCode="2323"
									UPIN="dfasfd"
									DentistLiecenseNumber="gdsdf"
									Email="sfsf@dddd.com"
									LIECENCENUMBER="gsgs"
									FAXTAXID="23"
									EN="asdsd"
									AddressLine2="asdsadxdsad"
									GaxenID="ds" ClinicName="sd" SpecialtyQualifier="sd" SpecialtyCode="sd" >
									
									</Prescriber>*/
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
			trace("SubscribePatientDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
		
		
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			trace("SubscribePatientDelegate -- > fault for call:<br>" + service.url + "<br> " + event.fault);
		}
		
		
	}
}