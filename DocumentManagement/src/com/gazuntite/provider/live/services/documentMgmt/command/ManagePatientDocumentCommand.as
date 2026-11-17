package com.gazuntite.provider.live.services.documentMgmt.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.ManagePatientDocumentDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.event.ManagePatientDocumentEvent;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMQuivusCombineEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class ManagePatientDocumentCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:ManagePatientDocumentDelegate;
		public var isUpdated 		: Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new ManagePatientDocumentDelegate(responder);			
			
			
			
			var LE:ManagePatientDocumentEvent = cgEvent as ManagePatientDocumentEvent;
			isUpdated = LE.isUpdated;
			if(LE.pateintDocument!=null){
				delegate.ManagePatientDocument(LE.pateintDocument);
			}
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			CursorManager.removeBusyCursor();
			var re:ResultEvent = event as ResultEvent;
			
			/*var arr:ObjectProxy = re.result.ArrayOfQUser as ObjectProxy;
			var array:ArrayCollection = arr.QUser as ArrayCollection;*/
			
			if( isUpdated )
				Alert.show("Record is successfully updated, Please press refresh button to view updated record.\n", "Info",4, FlexGlobals.topLevelApplication.mainContainer);
			
			//DMQuivusCombineEventDispatcher.LoadDocumentList(1);
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeAllCursors();
			Alert.show("Received In ManagePatientDocumentCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}