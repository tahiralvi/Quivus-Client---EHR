package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.LoadCPTMedicalTypesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.CPTMedicalTypeDTO;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.LoadCPTMedicalTypesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadCPTMedicalTypesCommand  implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadCPTMedicalTypesDelegate;		
		private var callBack			: Function;
		private var reqFrom:int;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadCPTMedicalTypesDelegate( responder );			
			
			var LE:LoadCPTMedicalTypesEvent = cgEvent as LoadCPTMedicalTypesEvent;
			
			if(LE.func != null)
				callBack = LE.func;
			
			if( LE.cptName != "" )
			{	
				reqFrom = LE.reqFrom;
				delegate.CPTMediacalTypeList( LE.cptName );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xCPTMedicalTypes:XMLList = ResultXml.CPTMedicalTypes.CPTMedicalType;
			var i:int = 0;					
			for( i = 0; i < xCPTMedicalTypes.length(); i++ )
			{
				var ct:CPTMedicalTypeDTO = new CPTMedicalTypeDTO();
				ct.FromXML( xCPTMedicalTypes[i][0] );
				Types.addItem( ct );
			}		
			if(reqFrom == 1)
				model.CPTMedicalTypeList = Types;	
			else if(reqFrom == 2)
				model.CPTMedicalTypeListOther = Types;
			
				
			trace( "model updated "  )
			
			if( null != callBack )
				callBack();			
			
			//trace( " after callBack() "  )
			
			trace( "on result found record ",Types.length );
		}
		
		private function onError(event:FaultEvent):void
		{			
			Alert.show("Received In LoadCPTMedicalTypesCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}