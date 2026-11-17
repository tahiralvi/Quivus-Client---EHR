package com.gazuntite.provider.live.services.elab.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.elab.delegate.ProcessLabOrderByCriteriaDelegate;
	import com.gazuntite.provider.live.services.elab.event.ProcessLabOrderByCriteriaEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ProcessLabOrderByCriteriaCommand implements Command
	{
		private var model:ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ProcessLabOrderByCriteriaDelegate;
		private var LE:ProcessLabOrderByCriteriaEvent;
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ProcessLabOrderByCriteriaDelegate( responder );			
			
			LE = event as ProcessLabOrderByCriteriaEvent;
			
			delegate.ProcessLabOrderByCriteria( LE.Criteria );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			//trace( "\n\nRESULT\n\n", event.result.toXMLString(), event.result.@Message );
			var status:XML = event.result as XML;
			//Alert.show( status.@Type + "\n" + status.@Message, "Server Responded with " + status.@Type  );
			Alert.show( status.@Message, '‘Alert’ ');
		}
		
		private function onError(event:FaultEvent):void
		{
			//Alert.show("Received In ProcessLabOrderByCriteriaCommand.\n" + event.toString(), ELabsConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			
			var errorStatus:String = "Fault occured in ProcessLabOrderByCriteriaCommand.";
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), model.LoggedInUserId ); 
		}
	}
}