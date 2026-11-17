package com.gazuntite.provider.live.services.administration.command.userManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.provider.live.services.administration.delegate.userManagement.UpdateUserStatusDelegate;
	import com.gazuntite.provider.live.services.administration.event.userManagement.LoadClinicBranchUsersEvent;
	import com.gazuntite.provider.live.services.administration.event.userManagement.UpdateUserStatusEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class UpdateUserStatusCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:UpdateUserStatusDelegate;
		[Bindable]
		private var action:String;
		[Bindable]
		private var actionVal:String;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new UpdateUserStatusDelegate( responder );			
			
			var LE:UpdateUserStatusEvent = cgEvent as UpdateUserStatusEvent;
			
			action 		= LE.action;
			actionVal	= LE.actionValue;
			delegate.UpdateUserStatus(LE.userId,LE.action,LE.actionValue);
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			CursorManager.removeBusyCursor();
			
			if(action == 'active' && actionVal == '1')
				Alert.show('Account has been successfully active', 'Account Active' ,4, FlexGlobals.topLevelApplication.mainContainer);
			else if(action == 'active' && actionVal == '0')
				Alert.show('Account has been successfully inactive', 'Account InActive' ,4, FlexGlobals.topLevelApplication.mainContainer);
			else if(action == 'locked' && actionVal == '1')
				Alert.show('Account has been successfully locked', 'Account locked' ,4, FlexGlobals.topLevelApplication.mainContainer);
			else if(action == 'locked' && actionVal == '0')
				Alert.show('Account has been successfully unlocked', 'Account unlocked' ,4, FlexGlobals.topLevelApplication.mainContainer);
			
			var lcbu:LoadClinicBranchUsersEvent = new LoadClinicBranchUsersEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent( lcbu );	
			CursorManager.setBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show("Received In UpdateUserStatusCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
		}
	}
}