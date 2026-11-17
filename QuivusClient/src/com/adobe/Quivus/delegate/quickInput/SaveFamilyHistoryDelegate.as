package com.adobe.Quivus.delegate.quickInput
{
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.serialization.json.JSON;
	import com.zigron.serialization.json.JSON_Zig;
	
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.MedicalHistoryDTO;

	public class SaveFamilyHistoryDelegate
	{
		private var responder	:IResponder;
		private var RestfulService		:HTTPService;
		
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.quickInput.SaveMedicalHistoryDelegate");
		
		public function SaveFamilyHistoryDelegate( responder : IResponder )
		{
			this.responder 				= responder;
			var url:String 				= Constants.RESTFUL_SERVICE_BASE_URL +  "ManagePatientMedicalHistoryList"; 
			
			RestfulService 				= new HTTPService(url);
			RestfulService.contentType 	= "application/json; charset=utf-8";
			RestfulService.method 		= URLRequestMethod.POST;
			
			RestfulService.addEventListener(FaultEvent.FAULT, onFault);
			RestfulService.addEventListener(ResultEvent.RESULT, onResult);
			
			this.responder = responder;	
		}
		
		public function SaveFamilyHistoryList(medicalHistoryList:Object,branchId:int,patientId:int):void
		{
			
			RestfulService.url = Constants.RESTFUL_SERVICE_BASE_URL +  "ManagePatientFamilyHistory/" + branchId + "/" + patientId;
			
			var json:String = JSON_Zig.encode(medicalHistoryList);
			
			
			logger.debug( "RestfulService.url: " + RestfulService.url );
			logger.debug( "json: " + json );
			
			RestfulService.send(json);
		}

		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			//logger.debug( "SearchProvider -- > result for call:<br>" + RestfulService.url + "<br> " + event.result);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}	
	}
}