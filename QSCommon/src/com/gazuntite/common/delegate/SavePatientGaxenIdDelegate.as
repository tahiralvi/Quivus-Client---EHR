package com.gazuntite.common.delegate
{
	import com.gazuntite.common.util.QSConstants;
	
	import mx.formatters.DateFormatter;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SavePatientGaxenIdDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		public function SavePatientGaxenIdDelegate( responder : IResponder)
		{
			this.responder 		= responder;
			var url:String 		= QSConstants.RESTFULL_PROVIDER_SERVICE_BASE_URL + "UpdateGaxenID/";
			service 			= new HTTPService(url);
			service.url 		= url;
			service.method		= "GET";
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
		}
		
		public function SaveGaxenId(userId:String, gaxenId:String, date:Date):void
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
			
			service.url = service.url +gaxenId + "/" + userId ;
			service.resultFormat = "e4x";
			service.send();	
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