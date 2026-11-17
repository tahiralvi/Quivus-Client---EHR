package com.gazuntite.provider.live.services.billing.command.report
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.report.ERAReportSetupDelegate;
	import com.gazuntite.provider.live.services.billing.dto.report.PaymentTransactionDTO;
	import com.gazuntite.provider.live.services.billing.event.report.ERAReportSetupEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ERAReportSetupCommand  implements Command
	{
		[Bindable]
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		public var callback:Function;
		private var responder:Responder;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{	
			
			responder = new Responder(result, fault);	
			
			if(model.LoggedInUserId)
			{
				var delegate : ERAReportSetupDelegate = new ERAReportSetupDelegate( responder );
				
				var LE:ERAReportSetupEvent 	= cgEvent as ERAReportSetupEvent;
				this.callback 							= LE.callback;
				
				delegate.LoadERAs(LE.searchXML);
				
			}
		}
		
		public function result( event : ResultEvent ) : void 
		{
			if(model.LoggedInUserId)
			{
				model.totalrecords_ERA = event.result.Paging.@['Total'];
				model.firstRecord_ERA = event.result.Paging.@['First'];
				model.lastRecord_ERA = event.result.Paging.@['Last'];
				
				if(model.totalrecords_ERA < BillingConstants.PAGE_SIZE)
					model.ERATotalPageNo = 1;
				else
				{
					var num:int = model.totalrecords_ERA % BillingConstants.PAGE_SIZE;
					if(num == 0)
					{
						model.ERATotalPageNo = model.totalrecords_ERA / BillingConstants.PAGE_SIZE;
					}
					else
					{
						model.ERATotalPageNo = model.totalrecords_ERA / BillingConstants.PAGE_SIZE + 1;
					}
				}
				
				if(model.totalrecords_ERA > 0)
					model.totalRecordMessage_ERA = "Total Records ("+ model.totalrecords_ERA.toString() +")";
				else
					model.totalRecordMessage_ERA = "No record found for given criteria";			
				
				var result:XML = event.result as XML ;		
				
				model.PaymentTransactionList = new ArrayCollection();
				
				var xTransactions:XMLList = result.PaymentTransactions.PaymentTransaction;
				for(var ic:int = 0; ic < xTransactions.length(); ic++)
				{
					var ps:PaymentTransactionDTO = new PaymentTransactionDTO();
					ps.FromXML( xTransactions[ic] );
					model.PaymentTransactionList.addItem(ps);
				}
				
				if( null != callback )
					callback();	
			}
		}
		
		public function fault( rpcEvent : FaultEvent ) : void 
		{
			Alert.show( "ERAReportSetupCommand.\n" + rpcEvent.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}