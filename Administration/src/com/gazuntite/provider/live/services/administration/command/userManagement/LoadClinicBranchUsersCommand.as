package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.delegate.roleManagement.LoadRoleDelegate;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.LoadClinicBranchUsersDelegate;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class LoadClinicBranchUsersCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadClinicBranchUsersDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadClinicBranchUsersDelegate( responder );			
			
			delegate.LoadClinicBranchUsers(model.loggedInUserSelectedBranchId );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			var op:ObjectProxy = (re.result as ObjectProxy);
			
			var resp:ObjectProxy  =  op.ClinicalUserResponceDTO  ;
			if(resp!=null)
			{
				if(resp.ResponseStatus)
				{
					model.ClinicalUserList = resp.Users.BaseUserDTO;
				}
				else
				{
					Alert.show("LoadClinicBranchUsers"+"\n"+resp.ResponseMessage, AdminConstant.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show("Received In LoadClinicBranchUsersCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
		}
	}
}