package com.gazuntite.provider.live.services.billing.command.report
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.report.SuperBillSummaryReportDelegate;
	import com.gazuntite.provider.live.services.billing.event.report.SuperBillSummaryReportEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class SuperBillSummaryReportCommand implements Command, IResponder
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		public var callback:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			/*
			if( ! NetworkU.Network.IsConnected )
			{
				Alert.show(Messages.NETWORK_NOT_AVAILABLE, Messages.NETWORK_ERROR);
				return;
			}*/
			
			if(model.LoggedInUserId)
			{
				var delegate : SuperBillSummaryReportDelegate = new SuperBillSummaryReportDelegate( this );
				
				var LE:SuperBillSummaryReportEvent 	= cgEvent as SuperBillSummaryReportEvent;
				this.callback 	= LE.callback;
				
			    delegate.GeneratePreview(LE.selectedBill);
			}
		}
		
		public function result( rpcEvent : Object ) : void 
		{			
			var re:ResultEvent = rpcEvent as ResultEvent;
			
			var resp:String = re.result.string as String;//   = re.result as QuickInputResponse  ;
			if(resp!=null && callback != null)
			{
				callback( resp, resp.indexOf("http://") == 0 );
			}
			
		}
		
		public function fault( rpcEvent : Object ) : void 
		{			
			callback( "Server Fault, please try later" );
			Alert.show("Fault occured in SuperBillSummaryReportCommand.\n"+rpcEvent.toString());			
		}
	}
}