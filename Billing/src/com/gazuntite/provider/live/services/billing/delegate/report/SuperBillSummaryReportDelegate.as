package com.gazuntite.provider.live.services.billing.delegate.report
{
	import com.gazuntite.provider.live.services.billing.dto.PendingBillsDTO;
	import com.zigron.serialization.json.JSON_Zig;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SuperBillSummaryReportDelegate
	{
		//private var logger:ILogger = Lo.getLogger("com.zigron.provider.live.services.billing.delegate.report.SuperBillSummaryReportDelegate");
		
		private var responder : IResponder;
		private var Service : HTTPService;
		
		public function SuperBillSummaryReportDelegate(responder : IResponder)
		{
			var url:String 			= "http://localhost:57737/Default.aspx" ;
			Service 				= new HTTPService(url);
			Service.contentType 	= "application/json; charset=utf-8";
			Service.method = "POST";
			Service.addEventListener(FaultEvent.FAULT, onFault);
			Service.addEventListener(ResultEvent.RESULT, onResult);
			
			this.responder = responder;	
		}
		
		public function GeneratePreview(superBill:PendingBillsDTO ): void 
		{
			Service.url = "http://localhost:57737/Default.aspx" ;
			var json:String = JSON_Zig.encode(superBill);
			
			//logger.debug( "url: " + Service.url );
			//logger.debug( "json: " + json );
			
			Service.send(json);	
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