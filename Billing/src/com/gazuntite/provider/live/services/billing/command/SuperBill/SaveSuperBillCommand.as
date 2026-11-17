package com.gazuntite.provider.live.services.billing.command.SuperBill
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.SuperBill.SaveSuperBillDelegate;
	import com.gazuntite.provider.live.services.billing.event.SuperBill.SaveSuperBillEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class SaveSuperBillCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:SaveSuperBillDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new SaveSuperBillDelegate( responder );				
			
			var LE:SaveSuperBillEvent = cgEvent as SaveSuperBillEvent;
			
			callBack = LE.callBack;
			if( LE.SuperBillXml != null )
			{	
				if(model.IsReport == true)
				{
					delegate.SaveSuperBill(LE.SuperBillXml );
				}
				else
				{
					delegate.SaveSuperBill(LE.SuperBillXml,"/" + LE.GenerateBill );
				}
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			trace( "onSuccess start "  )			
			
			if(model.IsReport == true)
			{				
				model.CurrentReportID = parseInt(event.result.toString()) ;
			}
			else
				model.Result = event.result.toString().toLowerCase()  == "true" ;
					
			callBack();
			trace( "model updated "  )			
			
			trace( " after callBack() "  )
			
			trace( "on result found result ", model.Result );
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "Received In SaveSuperBillCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}