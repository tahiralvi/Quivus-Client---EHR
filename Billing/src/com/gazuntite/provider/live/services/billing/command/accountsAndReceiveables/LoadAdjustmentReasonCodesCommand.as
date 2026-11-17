package com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.LoadAdjustmentReasonCodesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.AdjustmentReasonCodeDTO;
	import com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables.LoadAdjustmentReasonCodesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadAdjustmentReasonCodesCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadAdjustmentReasonCodesDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadAdjustmentReasonCodesDelegate( responder );			
			
			var LE:LoadAdjustmentReasonCodesEvent = cgEvent as LoadAdjustmentReasonCodesEvent;
			
			callBack = LE.callback;
			
			delegate.GetReasonCodes();
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			var result:XML = event.result as XML ;		
			
			model.AdjustmentReasonCodeList = new ArrayCollection();
			
			var xCodes:XMLList = result.AdjustmentReasonCodes.AdjustmentReasonCode;
			for(var ic:int = 0; ic < xCodes.length(); ic++)
			{
				var cr:AdjustmentReasonCodeDTO = new AdjustmentReasonCodeDTO();
				cr.FromXML( xCodes[ic] );
				model.AdjustmentReasonCodeList.addItem(cr);
			}
			
			model.AdjustmentReasonCodeListWOF = model.AdjustmentReasonCodeList;
			model.AdjustmentReasonCodeListADJ = model.AdjustmentReasonCodeList;
			model.AdjustmentReasonCodeListADM = model.AdjustmentReasonCodeList;
			
			
			if( null != callBack )
				callBack();			
			
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadPatientAccountCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}