package com.gazuntite.provider.live.services.billing.command.report
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.report.ERAClaimDetailReportDelegate;
	import com.gazuntite.provider.live.services.billing.event.report.ERAClaimDetailReportEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class ERAClaimDetailReportCommand implements Command
	{
		
		[Bindable]		
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		
		private var callback:Function;
		private var responder:Responder;		
		
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{		
			
			/*if( ! NetworkUtil.Network.IsConnected )
			{
			Alert.show(Messages.NETWORK_NOT_AVAILABLE, Messages.NETWORK_ERROR);
			return;
			}*/
			
			responder = new Responder(result, fault);	
			
			if(model.LoggedInUserId)
			{
				var delegate : ERAClaimDetailReportDelegate = new ERAClaimDetailReportDelegate( responder );
				
				var LE:ERAClaimDetailReportEvent 	= cgEvent as ERAClaimDetailReportEvent;
				callback 						= LE.callback;
				
				delegate.GeneratePreview(LE.ERAClaimDetailXML);
				
			}
		}
		
		public function result( rpcEvent : Object ) : void 
		{
			if(model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				re.result
				var resp:String = re.result.toString();
				if(resp!=null && resp != "" && callback != null)
				{
					trace( re.result, resp );
					callback( resp );						
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show( "ERAClaimDetailReportCommand.\n" + rpcEvent.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
			
		}
	}
}