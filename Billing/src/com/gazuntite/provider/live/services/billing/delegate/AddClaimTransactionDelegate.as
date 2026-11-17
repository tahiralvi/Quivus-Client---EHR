package com.gazuntite.provider.live.services.billing.delegate
{
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class AddClaimTransactionDelegate
	{
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		//private var responder	:IResponder;
		//private var uploadPath:String;
		
		public function AddClaimTransactionDelegate(responder : IResponder)
		{
			//this.responder = responder;				
			//uploadPath 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.ADD_CLAIM_TRANSACTIONS;
			
			this.responder 		= responder;
			var url:String 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.ADD_CLAIM_TRANSACTIONS;
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
		
		public function AddClaimTransaction(transactionXml:XML, managedByUserId:int ):void
		{
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.url =  service.url + "/" + managedByUserId;
			service.send( transactionXml );	
			trace( service.url );
			
			/*uploadPath = uploadPath +'/'+managedByUserId;
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = uploadPath;
			urlRequest.contentType = "Text/Xml"; 
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = transactionXml;
			urlRequest.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );
			
			var urlLoader:URLLoader = new URLLoader();
			
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onUploadingError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadingError);
			urlLoader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onUploadingError);
			urlLoader.addEventListener(Event.COMPLETE, onUploadingSuccess);
			
			urlLoader.load(urlRequest);*/
			
			//trace( "AddClaimTransactionDelegate", urlRequest.url );
				
		}
		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);			
		}
		
		/*private function onUploadingSuccess(event:Event):void
		{
			responder.result(event);
		}
		private function onUploadingError(event:IOErrorEvent):void
		{
			responder.fault(event);
		}*/
	}
}