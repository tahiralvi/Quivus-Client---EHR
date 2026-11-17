package com.gazuntite.provider.live.services.administration.command.roleManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.roleManagement.LoadRoleAccessRightDelegate;
	import com.gazuntite.provider.live.services.administration.dto.AccessRightDTO;
	import com.gazuntite.provider.live.services.administration.dto.RoleRightDTO;
	import com.gazuntite.provider.live.services.administration.event.roleManagement.LoadRoleAccessRightEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	public class LoadRoleAccessRightCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadRoleAccessRightDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadRoleAccessRightDelegate( responder );			
			
			var LE:LoadRoleAccessRightEvent = cgEvent as LoadRoleAccessRightEvent;
			
			if(LE.userTypeId>0)
			{
				delegate.LoadRoleAccessRight( LE.userTypeId,model.loggedInUserSelectedBranchId );
			}	
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			var type:String = result.ResponseStatus.toString();
			
			if(model.AccessRightDTOList)
			{
				model.AccessRightDTOList.removeAll();
				model.AccessRightDTOList = null;
			}
			
			model.AccessRightDTOList = new ArrayCollection();
			
			if( type.toLowerCase() == "true")
			{
				var i:int;
				for(i=0;i<result.Rights[0].children().length();i++){
					var lol:RoleRightDTO = new RoleRightDTO();
					lol.FromXML( result.Rights[0].children()[i] );
					
					model.AccessRightDTOList.addItem(lol);
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in LoadRoleAccessRightCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}