package com.gazuntite.provider.live.services.administration.command.roleManagement
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.live.services.administration.delegate.roleManagement.ManageRoleAccessRightDelegate;
	import com.gazuntite.provider.live.services.administration.dto.AccessRightDTO;
	import com.gazuntite.provider.live.services.administration.dto.RoleRightDTO;
	import com.gazuntite.provider.live.services.administration.event.roleManagement.ManageRoleAccessRightEvent;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ManageRoleAccessRightCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManageRoleAccessRightDelegate;
		private var func:Function;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageRoleAccessRightDelegate( responder );			
			
			var LE:ManageRoleAccessRightEvent = cgEvent as ManageRoleAccessRightEvent;
			
			this.func = LE.func;
			if(model.AccessRightDTOList!=null)
			{
				var xml:XML = XmlUtils.getNodeByTagName("Rights");
				
				for(var i:uint=0; i<model.AccessRightDTOList.length; i++)
				{
					var dto:RoleRightDTO = model.AccessRightDTOList.getItemAt(i) as RoleRightDTO;
					xml.appendChild(dto.ToXML());
				}
				
				delegate.ManageRoleAccessRight(xml, LE.userTypeId,model.loggedInUserSelectedBranchId );
			}
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			if(this.func != null)
			{
				this.func();
			}
			
			CursorManager.removeBusyCursor();
			Alert.show("Role Updated successfully.",  AdminConstant.INFO, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			var errorStatus:String = "Fault occured in ManageRoleAccessRightCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}