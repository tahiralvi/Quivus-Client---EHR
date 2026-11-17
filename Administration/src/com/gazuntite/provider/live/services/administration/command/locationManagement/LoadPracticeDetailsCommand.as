package com.gazuntite.provider.live.services.administration.command.locationManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.locationManagement.LoadPracticeDetailsDelegate;
	import com.gazuntite.provider.live.services.administration.event.locationManagement.LoadPracticeDetailsEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadPracticeDetailsCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadPracticeDetailsDelegate;
		
		public function execute(cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadPracticeDetailsDelegate( responder );	
			
			var LE:LoadPracticeDetailsEvent = cgEvent as LoadPracticeDetailsEvent;
			
			delegate.LoadPracticeDetails(LE.clinicBranchID );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			var re:ResultEvent = event as ResultEvent;
			var op:ObjectProxy = (re.result as ObjectProxy);
			
			if(op!=null)
			{
				model.practiceDetailProxyObj = op.ClinicBranchDTO ;
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			var errorStatus:String = "Fault occured in LoadPracticeDetailsCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
		
	}
}