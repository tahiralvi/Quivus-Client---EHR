package com.gazuntite.provider.live.services.billing.command.ClaimManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.ClaimManagement.SendClaimsForProcessingDelegate;
	import com.gazuntite.provider.live.services.billing.event.ClaimManagement.SendClaimsForProcessingEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class SendClaimsForProcessingCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:SendClaimsForProcessingDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new SendClaimsForProcessingDelegate( responder );			
			
			var LE:SendClaimsForProcessingEvent = cgEvent as SendClaimsForProcessingEvent;
			
			callBack = LE.callBack;
			
			delegate.SendWithCriteria(LE.EDIReceiverID, LE.insuranceTypeId, LE.clinicBranchId, LE.processedByUserID );
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			if( null != callBack )
				callBack(event.result.toString());			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllClaimbyProviderIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}