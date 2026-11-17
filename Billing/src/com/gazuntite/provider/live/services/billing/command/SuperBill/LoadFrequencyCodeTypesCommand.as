package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.LoadFrequencyCodeTypesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.FrequencyCodeTypeDTO;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.LoadFrequencyCodeTypesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadFrequencyCodeTypesCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadFrequencyCodeTypesDelegate;		
		//private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadFrequencyCodeTypesDelegate( responder );			
			
			var LE:LoadFrequencyCodeTypesEvent = cgEvent as LoadFrequencyCodeTypesEvent;
			
			//callBack = LE.callBack;
			if( LE != null )
			{				
				delegate.FrequencyCodeTypeList();				
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xFrequencyCodeTypes:XMLList = ResultXml.FrequencyCodeTypes.FrequencyCodeType;
			var i:int = 0;					
			for( i = 0; i < xFrequencyCodeTypes.length(); i++ )
			{
				var ct:FrequencyCodeTypeDTO = new FrequencyCodeTypeDTO();
				ct.FromXML( xFrequencyCodeTypes[i][0] );
				Types.addItem( ct );
			}		
			
			model.FrequencyCodeList = Types;
			
			trace( "model updated "  )
			
			//if( null != callBack )
			//callBack();			
			
			//trace( " after callBack() "  )
			
			trace( "on result found record ", Types.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadENMCodeTypesCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}