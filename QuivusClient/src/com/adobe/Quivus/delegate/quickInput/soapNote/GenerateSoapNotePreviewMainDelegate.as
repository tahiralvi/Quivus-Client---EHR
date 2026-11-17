package com.adobe.Quivus.delegate.quickInput.soapNote
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.QuickInputDTO;
	import valueObjects.UserSessionDTO;
	
	public class GenerateSoapNotePreviewMainDelegate extends BaseDelegate
	{
		private var logger:ILogger = Log.getLogger("com.adobe.Quivus.delegate.quickInput.soapNote.GenerateSoapNotePreviewDelegate");
		[Bindable]
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var responder : IResponder;
		private var RestfulService : HTTPService;
		
		public function GenerateSoapNotePreviewMainDelegate(  responder : IResponder )
		{		
			var url:String 				= Constants.RESTFUL_SERVICE_BASE_URL + "GenerateSoapNoteByVisitID/" ;
			RestfulService 				= new HTTPService(url);
			RestfulService.contentType 	= "application/json; charset=utf-8";
			RestfulService.method 		= "POST";
			RestfulService.addEventListener(FaultEvent.FAULT, onFault);
			RestfulService.addEventListener(ResultEvent.RESULT, onResult);
			
			this.responder = responder;				
		}
		
		public function GeneratePreview(quickInputDTO:QuickInputDTO, VisitID:int, userSession:UserSessionDTO, clinicBranchId:int, stationIds:ArrayCollection, isAllSelected:Boolean, isPatientMale:Boolean, isTemp:Boolean): void 
		{
			if(model.gaxenID.length==0)
				model.gaxenID = '0';
			
			RestfulService.url = Constants.RESTFUL_SERVICE_BASE_URL + "GenerateSoapNoteByVisitID/" + VisitID + "/" + userSession.SessionID + "/" + clinicBranchId + "/" + stationIds + "/" + isAllSelected + "/" + isPatientMale + "/" + isTemp + "/"+ model.gaxenID ;
			var json:String = JSON_Zig.encode(quickInputDTO);
			
			logger.debug( "RestfulService.url: " + RestfulService.url );
			logger.debug( "json: " + json );
			
			RestfulService.send(json);	
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