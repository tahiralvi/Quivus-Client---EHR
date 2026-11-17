package com.gazuntite.provider.live.services.administration.command.accessRightManag
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.xml.XmlUtils;
	import com.gazuntite.provider.live.services.administration.delegate.accessRightManagement.ManageUserAccessRightDelegate;
	import com.gazuntite.provider.live.services.administration.delegate.roleManagement.ManageRoleAccessRightDelegate;
	import com.gazuntite.provider.live.services.administration.dto.AccessRightDTO;
	import com.gazuntite.provider.live.services.administration.event.accessRightManagement.ManageUserAccessRightEvent;
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
	
	public class ManageUserAccessRightCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:ManageUserAccessRightDelegate;
		private var func:Function;
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new ManageUserAccessRightDelegate( responder );			
			
			var LE:ManageUserAccessRightEvent = cgEvent as ManageUserAccessRightEvent;
			func = LE.func;
			if(model.UserAccessRightDTOList!=null)
			{
				var xml:XML = XmlUtils.getNodeByTagName("Rights");
				
				for(var i:uint=0; i<model.UserAccessRightDTOList.length; i++)
				{
					var dto:AccessRightDTO = model.UserAccessRightDTOList.getItemAt(i) as AccessRightDTO;
					xml.appendChild(dto.ToXML());
				}
				delegate.ManageUserAccessRight(xml,LE.userId, LE.branchId );
			}			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			//var re:ResultEvent = event as ResultEvent;
			if(model.UserAccessRightDTOList)
				model.UserAccessRightDTOList.removeAll();
			
			if(this.func != null)
			{
				this.func();
			}
			CursorManager.removeBusyCursor();
			Alert.show("Access right updated successfully.", AdminConstant.INFO, 4, FlexGlobals.topLevelApplication.mainContainer);
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			//Alert.show("Received In ManageUserAccessRightCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			var errorStatus:String = "Fault occured in ManageUserAccessRightCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}