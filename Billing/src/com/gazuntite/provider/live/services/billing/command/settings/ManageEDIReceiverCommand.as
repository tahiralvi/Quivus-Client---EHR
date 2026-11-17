package com.gazuntite.provider.live.services.billing.command.settings
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.settings.ManageEDIReceiverDelegate;
	import com.gazuntite.provider.live.services.billing.event.settings.ManageEDIReceiverEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class ManageEDIReceiverCommand implements Command
	{
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManageEDIReceiverDelegate;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageEDIReceiverDelegate( responder );				
			
			var LE:ManageEDIReceiverEvent = cgEvent as ManageEDIReceiverEvent;
			
			callBack = LE.callBack;
			if( LE.xmlDocument != null )
			{	
				delegate.ManageEDIReceiver(LE.xmlDocument);
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{			
			//model.Result = event.result.toString().toLowerCase()  == "true" ;
			callBack(event.result.toString().toLowerCase());
		}
		
		private function onError(event:FaultEvent):void
		{
			Alert.show( "ManageEDIReceiverCommand.\n" + event.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
		}
	}
}