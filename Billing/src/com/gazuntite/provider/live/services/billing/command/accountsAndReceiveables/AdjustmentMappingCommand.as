package com.gazuntite.provider.live.services.billing.command.accountsAndReceiveables
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.accountsAndReceiveables.AdjustmentMappingDelegate;
	import com.gazuntite.provider.live.services.billing.dto.accountsAndReceiveables.AdjustmentMappingDTO;
	import com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables.AdjustmentMappingEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class AdjustmentMappingCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder		:Responder;
		private var delegate		:AdjustmentMappingDelegate;
		private var callBack		: Function;
		private var LE				:AdjustmentMappingEvent
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new AdjustmentMappingDelegate( responder );				
			
			LE = cgEvent as AdjustmentMappingEvent;
			
			callBack = LE.callBack;
			if( LE.xmlDocument != null )
			{	
				delegate.ManageAdjustmentMapping(LE.xmlDocument);
			}	
			else
			{
				delegate.LoadAdjustmentMapping();
			}
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			if( LE.xmlDocument != null )
			{	
				callBack(event.result.toString().toLowerCase());
			}	
			else 
			{			
				var result:XML = event.result as XML ;		
				
				model.AdjustmentMappingList = new ArrayCollection();
				
				var xMapping:XMLList = result.AdjustmentMappings.AdjustmentMapping;
				for(var ic:int = 0; ic < xMapping.length(); ic++)
				{
					var adm:AdjustmentMappingDTO = new AdjustmentMappingDTO();
					adm.FromXML( xMapping[ic] );
					model.AdjustmentMappingList.addItem(adm);
				}
				
				if( null != callBack )
					callBack();	
			}		
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "AdjustmentMappingCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}