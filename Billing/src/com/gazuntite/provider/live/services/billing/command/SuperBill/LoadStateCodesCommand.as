package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.LoadStateCodesDelegate;
	import com.gazuntite.provider.live.services.billing.dto.SuperBill.StateCodeDTO;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.LoadStateCodesEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadStateCodesCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadStateCodesDelegate;		
		//private var callBack			: Function;
				
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadStateCodesDelegate( responder );			
			
			var LE:LoadStateCodesEvent = cgEvent as LoadStateCodesEvent;
			
			//callBack = LE.callBack;
						
			delegate.StateCodeList();
						
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )		
			
			var Types:ArrayCollection =new ArrayCollection();
			
			var ResultXml:XML = event.result as XML
			var xStateCodes:XMLList = ResultXml.States.State;
			var i:int = 0;					
			for( i = 0; i < xStateCodes.length(); i++ )
			{
				var ct:StateCodeDTO = new StateCodeDTO();
				ct.FromXML( xStateCodes[i][0] );
				Types.addItem( ct );
			}		
			
			model.StateCodeList = Types;
			
			trace( "model updated "  )
			
			//if( null != callBack )
			//callBack();			
			
			//trace( " after callBack() "  )
			
			trace( "on result found record ", Types.length );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In LoadStateCodesCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}