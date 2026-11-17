package com.gazuntite.provider.live.services.billing.command.report
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.delegate.report.PatientStatementReportDelegate;
	import com.gazuntite.provider.live.services.billing.event.report.PatientStatementReportEvent;
	import com.gazuntite.provider.live.services.billing.model.BillingModelLocator;
	import com.gazuntite.provider.live.services.billing.util.BillingConstants;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;

	public class PatientStatementReportCommand implements Command
	{
		[Bindable]
		private var model : BillingModelLocator = BillingModelLocator.getInstance();
		public var callback:Function;
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
				var delegate : PatientStatementReportDelegate = new PatientStatementReportDelegate( responder );
				
				var LE:PatientStatementReportEvent 	= cgEvent as PatientStatementReportEvent;
				this.callback 							= LE.callback;
				
				delegate.GeneratePreview(LE.statementXML);
				
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
					//callback( resp, resp.indexOf("http://") == 0 );
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show( "PatientStatementReportCommand.\n" + rpcEvent.toString(), BillingConstants.ERROR, 4, FlexGlobals.topLevelApplication as Sprite );
			//callback( "Server Fault, please try later" );
			
			//var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			//QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}