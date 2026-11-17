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

	public class SaveQuivusManagerDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		
		public function SaveQuivusManagerDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			
			//var url:String 		= "http://www.quivus.com/QuivusAirDev/UserService/Service/RestfulService/UserManagerRestfulService.svc/UpdateUser";
	//		var url:String 		= EConstants.RESTFULL_USER_SERVICE_BASE_URL + "UpdateUser";
			var url:String 		= 'http://beta.quivus.com/Eprescriptionstagging/Service/EPrescriptionService.svc/' + "UpdateUser";
			
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
	
		public function SaveQuivusManager(data:XML, date:Date):void
		{
			trace("Save QM patient");
			trace("Save QM XML before passing to service", data.toXMLString());
			
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
			//service.url += "/" + d;
			
			
			
			
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
		

		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			trace("SaveQuivusManagerDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
		
		
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			trace("SaveQuivusManagerDelegate -- > fault for call:<br>" + service.url + "<br> " + event.fault);
		}
		
		
	}
}