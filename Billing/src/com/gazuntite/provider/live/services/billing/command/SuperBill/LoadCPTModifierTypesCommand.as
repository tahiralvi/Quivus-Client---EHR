package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.LoadCPTModifierTypesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.CPTModifierTypeDTO;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.LoadCPTModifierTypesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadCPTModifierTypesCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadCPTModifierTypesDelegate;		
		private var callBack			: Function;
		private var modifierNo:int	;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadCPTModifierTypesDelegate( responder );			
			
			var LE:LoadCPTModifierTypesEvent = cgEvent as LoadCPTModifierTypesEvent;
			
			callBack = LE.callBack;
			if( LE.modifierCode != "" )
			{				
				delegate.CPTModifierTypeList(LE.modifierCode );
				this.modifierNo = LE.modifierNo
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xCPTModifierTypes:XMLList = ResultXml.CPTModifierTypes.CPTModifierType;
			var i:int = 0;					
			for( i = 0; i < xCPTModifierTypes.length(); i++ )
			{
				var ct:CPTModifierTypeDTO = new CPTModifierTypeDTO();
				ct.FromXML( xCPTModifierTypes[i][0] );
				Types.addItem( ct );
			}		
			if(modifierNo == 1)
				model.CPTModifierTypeList1 = Types;	
			else if(modifierNo == 2)
				model.CPTModifierTypeList2 = Types;
			else if(modifierNo == 3)
				model.CPTModifierTypeList3 = Types;
			else if(modifierNo == 4)
				model.CPTModifierTypeList4 = Types;
			
			trace( "model updated "  )
			
			if( null != callBack )
			callBack();			
			
			//trace( " after callBack() "  )
			
			trace( "on result found record ", Types.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadCPTModifierTypesCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}