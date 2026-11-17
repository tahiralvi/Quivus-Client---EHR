package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.ManagePendingBillProceduresDelegate;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.ManagePendingBillProceduresEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ManagePendingBillProceduresCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManagePendingBillProceduresDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManagePendingBillProceduresDelegate( responder );				
			
			var LE:ManagePendingBillProceduresEvent = cgEvent as ManagePendingBillProceduresEvent;
			
			callBack = LE.callBack;
			if( LE.ProcedureXml != null )
			{				
				delegate.ManagePendingBillProcedures(LE.ProcedureXml );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )			
			
			model.Result = event.result.toString().toLowerCase()  == "true" ;
				
			callBack();
			trace( "model updated "  )			
			
			trace( " after callBack() "  )
			
			trace( "on result found result ", model.Result );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "Received In ManagePendingBillProceduresCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}