package com.gazuntite.provider.live.services.elab.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.elab.delegate.EnterResultDelegate;
	import com.gazuntite.provider.live.services.elab.event.EnterResultEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class EnterResultCommand implements Command
	{
		private var model:ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:EnterResultDelegate;
		private var LE:EnterResultEvent;
		
		public function execute(event:CairngormEvent):void
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new EnterResultDelegate( responder );			
			
			LE = event as EnterResultEvent;
			
			delegate.EnterResult( LE.Lab.OrderID, LE.ResultRanage );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			trace( event.result );
			Alert.show( "Result Saved Successfully", "Result Saved", Alert.OK, FlexGlobals.topLevelApplication.mainContainer );
			if( LE.callBack() != null )
				LE.callBack();
		}
		
		private function onError(event:FaultEvent):void
		{
			//Alert.show("Received In EnterResultCommand.\n" + event.toString(), ELabsConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			
			var errorStatus:String = "Fault occured in EnterResultCommand.";
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), model.LoggedInUserId ); 
			
		}
	}
}