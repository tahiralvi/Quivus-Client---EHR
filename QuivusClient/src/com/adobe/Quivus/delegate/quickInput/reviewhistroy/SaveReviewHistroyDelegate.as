package com.adobe.Quivus.delegate.quickInput.reviewhistroy
{
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.cairngorm.business.Responder;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import valueObjects.UserSessionDTO;

	public class SaveReviewHistroyDelegate
	{
		private var responder : IResponder ;
		private  var service  : HTTPService;
		private var  url      : String;
		
		public function SaveReviewHistroyDelegate(responder:IResponder)
		{
			this.responder      = responder;
			url				    = Constants.QI_SAVING_RESTFUL_SERVICE + 'ManageVisitReviewByVisitIDAndProviderID';
			service				= new HTTPService(url);
			//service.url			= url;
			service.method		="POST";
			service.contentType	= 'application/xml';
			
			
		}
		public function SaveHistroy(sessionID: String,visitID:int,providerId:int,ReviewHistroyXML:XML):void
		{
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.url = url + "/" + sessionID + "/" + visitID + "/" + providerId ;
			service.resultFormat = "e4x";
			service.send(ReviewHistroyXML  );
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