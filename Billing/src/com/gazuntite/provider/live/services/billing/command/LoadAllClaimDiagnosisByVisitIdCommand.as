package com.gazuntite.provider.live.services.billing.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.LoadAllClaimDiagnosisByVisitIdDelegate;
	import com.gazuntite.provider.live.services.billing.event.LoadAllClaimDiagnosisByVisitIdEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadAllClaimDiagnosisByVisitIdCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAllClaimDiagnosisByVisitIdDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAllClaimDiagnosisByVisitIdDelegate( responder );			
			
			var LE:LoadAllClaimDiagnosisByVisitIdEvent = cgEvent as LoadAllClaimDiagnosisByVisitIdEvent;
			
			callBack = LE.callBack;
			if( LE.visitId > 0 )
			{				
				delegate.SearchClaimDiagnoses( LE.visitId );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			model.SearchClaimDiagnoses = event.result.toString() ;		
			
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			trace( " after callBack() "  )
			
			trace( "on result found string ", model.SearchClaimDiagnoses );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadAllClaimbyProviderIdCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}