package com.gazuntite.provider.live.services.billing.command
{	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.AddClaimTransactionDelegate;
	import com.gazuntite.provider.live.services.billing.event.AddClaimTransactionEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	

	public class AddClaimTransactionCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:mx.rpc.Responder;
		private var delegate:AddClaimTransactionDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new AddClaimTransactionDelegate( responder );				
			
			var LE:AddClaimTransactionEvent = cgEvent as AddClaimTransactionEvent;
			
			callBack = LE.callBack;
			if( LE.managedByUserId > 0 )
			{				
				delegate.AddClaimTransaction(LE.transactionXml,LE.managedByUserId );
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
			Alert.show( "Received In AddClaimTransactionCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}