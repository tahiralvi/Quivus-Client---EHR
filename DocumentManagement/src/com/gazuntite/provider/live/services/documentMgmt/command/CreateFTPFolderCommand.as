package com.gazuntite.provider.live.services.documentMgmt.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.documentMgmt.delegat.CreateFTPFolderDelegate;
	import com.gazuntite.provider.live.services.documentMgmt.event.CreateFTPFolderEvent;
	import com.gazuntite.provider.live.services.documentMgmt.model.DMAppModelLocator;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMConstant;
	import com.gazuntite.provider.live.services.documentMgmt.util.DMUtilityFunction;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	
	public class CreateFTPFolderCommand  implements com.adobe.cairngorm.commands.Command {
		
		private var model 				: DMAppModelLocator = DMAppModelLocator.getInstance();
		
		private var responder			:Responder;
		private var delegate			:CreateFTPFolderDelegate;
		
		private var func:Function;
		private var patientID:int;
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder                 	= new Responder(onSuccess, onError);				
			delegate               		= new CreateFTPFolderDelegate(responder);			
			
			
			
			var LE:CreateFTPFolderEvent = cgEvent as CreateFTPFolderEvent;
			this.func = LE.func;
			this.patientID = LE.patientId;
			delegate.CreateFTPFolder(LE.path);
			
			
		}
		
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			if(re!=null && re.result!=null )
			{
				
				
				if(this.func!=null)
				{
					func(this.patientID);
				}
			}
		}
		
		
		
		
		
		private function onError(event:FaultEvent):void
		{
			Alert.show("Received In CreateFTPFolderCommand.\n"+event.toString(), DMConstant.ERROR,4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		
	}
}