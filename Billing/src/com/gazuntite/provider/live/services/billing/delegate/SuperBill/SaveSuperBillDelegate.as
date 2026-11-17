package com.gazuntite.provider.live.services.billing.delegate.SuperBill
{
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	import com.gazuntite.provider.live.services.billing.util.BillingServiceMethods;
	
	import flash.net.URLRequestMethod;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SaveSuperBillDelegate
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		private var logger:ILogger = Log.getLogger("com.gazuntite.provider.live.services.billing.delegate.SuperBill.SaveSuperBillDelegate");
		
		public function SaveSuperBillDelegate(responder	:IResponder)
		{
			var url:String;
			this.responder 		= responder;
			if(model.IsReport == true)
				url 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.SAVE_REPORT;
			else
				url 		= BillingConstants.RESTFULL_SERVICE_BASE_URL + BillingServiceMethods.SAVE_SUPER_BILL;
			
			service 			= new HTTPService(url);
			service.url 		= url;			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
		public function SaveSuperBill(SuperBillXml:XML, GenerateBill:String = "" ):void
		{	
			service.url = service.url + GenerateBill;
			service.resultFormat 	= "e4x";
			service.contentType 	= "Text/Xml"; 
			service.method 			= URLRequestMethod.POST;
			service.send( SuperBillXml );	
			trace( service.url );
			
			/*var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = uploadPath;
			urlRequest.contentType = "Text/Xml"; 
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = SuperBillXml;
			urlRequest.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );
			
			var urlLoader:URLLoader = new URLLoader();
			
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onUploadingError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadingError);
			urlLoader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onUploadingError);
			urlLoader.addEventListener(Event.COMPLETE, onUploadingSuccess);
			
			urlLoader.load(urlRequest);
			
			trace( "SaveSuperBillDelegate", urlRequest.url );*/
			
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