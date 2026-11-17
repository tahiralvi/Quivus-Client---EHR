package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.SaveStationDetailsDelegate;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.SaveStationDetailsEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class SaveStationDetailsCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:SaveStationDetailsDelegate;
		private var func:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new SaveStationDetailsDelegate( responder );	
			
			var LE:SaveStationDetailsEvent = cgEvent as SaveStationDetailsEvent;
			this.func = LE.func;
			
			delegate.SaveStationDetails(LE.adminStationXML, model.loggedInUserId);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			CursorManager.removeBusyCursor();
			
			if(this.func != null)
			{
				this.func();
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in SaveStationDetailsCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}