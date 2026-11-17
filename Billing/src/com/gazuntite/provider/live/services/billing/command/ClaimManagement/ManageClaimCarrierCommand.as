package com.gazuntite.provider.live.services.billing.command.ClaimManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.ManageClaimCarrierDelegate;
	import com.gazuntite.provider.live.services.billing.event.ClaimManagement.ManageClaimCarrierEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ManageClaimCarrierCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManageClaimCarrierDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageClaimCarrierDelegate( responder );				
			
			var LE:ManageClaimCarrierEvent = cgEvent as ManageClaimCarrierEvent;
			
			callBack = LE.callBack;
			if( LE.claimCarrier != null )
			{	
				delegate.ManageClaimCarrier(LE.claimCarrier,LE.claimNote, LE.saveCarriers );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			model.Result = event.result.toString().toLowerCase()  == "true" ;
			
			callBack();
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "ManageClaimCarrierCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}