package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.LoadICDCodeTypesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.ICDCodeTypeDTO;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.LoadICDCodeTypesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadICDCodeTypesCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadICDCodeTypesDelegate;		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadICDCodeTypesDelegate( responder );			
			
			var LE:LoadICDCodeTypesEvent = cgEvent as LoadICDCodeTypesEvent;
			
			if(LE.func != null)
				callBack = LE.func;
			if( LE.ICDCodeName != "" )
			{				
				delegate.ICDCodeTypeList( LE.ICDCodeName,LE.clinicBranchID );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xICDCodeTypes:XMLList = ResultXml.DiseaseTypes.DiseaseType;
			var i:int = 0;					
			for( i = 0; i < xICDCodeTypes.length(); i++ )
			{
				var ct:ICDCodeTypeDTO = new ICDCodeTypeDTO();
				ct.FromXML( xICDCodeTypes[i][0] );
				Types.addItem( ct );
			}		
			
			model.ICDCodeTypeList = Types;			
			
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			//trace( " after callBack() "  )
			
			trace( "on result found record ", model.ICDCodeTypeList.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadICDCodeTypesCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}