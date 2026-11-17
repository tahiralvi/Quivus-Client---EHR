package com.gazuntite.provider.live.services.billing.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.LoadAllClaimTransactionByClaimIdDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SearchClaimTransactionResultsList;
	import com.gazuntite.provider.live.services.billing.event.LoadAllClaimTransactionByClaimIdEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadAllClaimTransactionByClaimIdCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllClaimTransactionByClaimIdDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllClaimTransactionByClaimIdDelegate( responder );			
		
			var LE:LoadAllClaimTransactionByClaimIdEvent = cgEvent as LoadAllClaimTransactionByClaimIdEvent;
				
			callBack = LE.callBack;
			if( LE.claimId > 0 )
			{				
				delegate.SearchClaimTransactionList(LE.claimId );
			}			
		}
			
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )
			
			var ctsl:SearchClaimTransactionResultsList = new SearchClaimTransactionResultsList();
			ctsl.FromXML( event.result as XML );
			
			model.SearchClaimTransactionResults = ctsl;		
			
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			trace( " after callBack() "  )
			
			trace( "on result found record ", ctsl.ClaimTransactions.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllClaimTransactionByClaimIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}