package com.gazuntite.provider.live.services.elab.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.elab.delegate.ProcessLabResultByCriteriaDelegate;
	import com.gazuntite.provider.live.services.elab.event.ProcessLabResultByCriteriaEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ProcessLabResultByCriteriaCommand implements Command
	{
		private var model:ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ProcessLabResultByCriteriaDelegate;
		private var LE:ProcessLabResultByCriteriaEvent;
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ProcessLabResultByCriteriaDelegate( responder );			
			
			LE = event as ProcessLabResultByCriteriaEvent;
			
			delegate.ProcessLabResultByCriteria( LE.Criteria );
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
			//Alert.show("Received In ProcessLabResultByCriteriaCommand.\n" + event.toString(), ELabsConstant.ERROR, Alert.OK, FlexGlobals.topLevelApplication.mainContainer );
			
			var errorStatus:String = "Fault occured in ProcessLabResultByCriteriaCommand.";
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), model.LoggedInUserId ); 
		}
	}
}