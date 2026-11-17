package com.gazuntite.provider.live.services.administration.command.roleManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.roleManagement.LoadRoleDelegate;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class LoadRoleCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadRoleDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadRoleDelegate( responder );			
			
			delegate.LoadRoles(  );
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			
			var op:ObjectProxy = (re.result as ObjectProxy);
			
			var userTypeResponce:ObjectProxy  =  op.UserTypeResponce ;
			if(userTypeResponce!=null)
			{
				if(userTypeResponce.ResponseStatus)
				{
					model.UserRoleList = userTypeResponce.UserTypeDTOList.UserTypeDTO;
				}
				else
				{
					Alert.show("LoadRole"+"\n"+userTypeResponce.ResponseMessage, AdminConstant.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in LoadRoleCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}