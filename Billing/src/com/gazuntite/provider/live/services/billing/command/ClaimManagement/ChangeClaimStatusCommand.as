package com.gazuntite.provider.live.services.billing.command.ClaimManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.ChangeClaimStatusDelegate;
	import com.gazuntite.provider.live.services.billing.event.ClaimManagement.ChangeClaimStatusEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ChangeClaimStatusCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ChangeClaimStatusDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ChangeClaimStatusDelegate( responder );				
			
			var LE:ChangeClaimStatusEvent = cgEvent as ChangeClaimStatusEvent;
			
			callBack = LE.callBack;
			if( LE.IDsXml != null )
			{					
				delegate.ChangeClaimStatus(LE.IDsXml,LE.statusTypeIdFrom,LE.statusTypeIdTo,LE.mediaTypeIdFrom,LE.mediaTypeIdTo,LE.insuranceTypeId,LE.managedByUserId );				
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			model.Result = event.result.toString().toLowerCase()  == "true" ;
			
			callBack();
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "Received In ChangeClaimStatusCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}