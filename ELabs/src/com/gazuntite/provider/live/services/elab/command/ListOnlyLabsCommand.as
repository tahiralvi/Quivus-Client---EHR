package com.gazuntite.provider.live.services.elab.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.provider.live.services.elab.delegate.ListOnlyLabsDelegate;
	import com.gazuntite.provider.live.services.elab.dto.LabListDTO;
	import com.gazuntite.provider.live.services.elab.event.ListOnlyLabsEvent;
	import com.gazuntite.provider.live.services.elab.model.ELabsAppModelLocator;
	import com.gazuntite.provider.live.services.elab.util.ELabsConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ListOnlyLabsCommand implements Command
	{
		private var model:ELabsAppModelLocator = ELabsAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ListOnlyLabsDelegate;
		private var LE:ListOnlyLabsEvent;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ListOnlyLabsDelegate( responder );			
			
			LE = cgEvent as ListOnlyLabsEvent;
			
			if( LE.SearchResults )
			{
				delegate.ListOnlyResults(LE.clinicBranchID, LE.pageNo,  LE.query );
			}
			else
			{
				delegate.ListOnlyOrders(LE.clinicBranchID, LE.pageNo,  LE.query );
			}
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			var xStatus:XML = result.Status[0];
			var type:String = xStatus.@[XmlConstants.TYPE];
			if( type.toLowerCase() == "success")
			{
				var ll:LabListDTO = new LabListDTO();
				ll.FromXML( result );
				
				if( LE.SearchResults )
					model.LabResultListDto = ll;
				else
					model.LabOrderListDto = ll;
				
			}
			else
			{
				Alert.show("List Only\nServer Responded with status typke " + type + "\n server status message is " + xStatus.@[XmlConstants.MESSAGE], "Response status " + type );
			}
			trace( event.result );
		}
		
		private function onError(event:FaultEvent):void
		{
			//Alert.show("Received In ListOnlyLabsCommand.\n" + event.toString(), ELabsConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			
			var errorStatus:String = "Fault occured in ListOnlyLabsCommand.";
			
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), model.LoggedInUserId ); 
		}
	}
}