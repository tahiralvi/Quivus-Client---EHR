package com.adobe.Quivus.delegate.quickInput.reviewhistroy
{
	
	import com.adobe.Quivus.utils.Constants;
	
	import flash.net.getClassByAlias;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	public class LoadReviewHistroyDelegate
	{	
		var responder   : IResponder ; 
		var service     : HTTPService;
		var url         : String;
		
		public function LoadReviewHistroyDelegate(responder:IResponder)
		{
			this.responder 			= responder ;
			this.url	   			= Constants.QI_SAVING_RESTFUL_SERVICE+'LoadVisitReviewByVisitIDAndProvideID';
			service        			= new HTTPService(this.url);
			service.method 			= 'Get';
			service.contentType		= 'Text';
		}
		
		public function LoadHistroy(sessionId:String,visitId:int,providerId:int):void 
		{
			service.addEventListener(ResultEvent.RESULT,onSuccess);
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.url =  url + "/" + sessionId + "/" + visitId + "/" + providerId ;
			//trace(service.url);
			service.resultFormat = "e4x";
			service.send();
			
		}
		
		private function onSuccess(resultEvent:ResultEvent):void
		{
			responder.result(resultEvent);
		}
		public function onFault(faultEvent:FaultEvent):void
		{
			responder.fault(faultEvent);
		}
		
	}
	
}