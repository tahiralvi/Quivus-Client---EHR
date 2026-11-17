package com.gazuntite.provider.live.services.administration.command.accessRightManag
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.accessRightManagement.LoadSelectedUserAccessRightDelegate;
	import com.gazuntite.provider.live.services.administration.dto.AccessRightDTO;
	import com.gazuntite.provider.live.services.administration.event.accessRightManagement.LoadSelectedUserAccessRightEvent;
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
	
	public class LoadSelectedUserAccessRightCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadSelectedUserAccessRightDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadSelectedUserAccessRightDelegate( responder );	
			
			//model.UserAccessRightDTOList = new ArrayCollection();
			
			var LE:LoadSelectedUserAccessRightEvent = cgEvent as LoadSelectedUserAccessRightEvent;
			
			if(LE.userId>0 && LE.userTypeId>0)
				delegate.LoadUserAccessRight(LE.userId,LE.userTypeId,model.loggedInUserSelectedBranchId  );
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var result:XML = event.result as XML;
			var type:String = result.ResponseStatus.toString();
			
			if(model.UserAccessRightDTOList)
			{
				model.UserAccessRightDTOList.removeAll();
				model.UserAccessRightDTOList = null;
			}
			
			model.UserAccessRightDTOList = new ArrayCollection();
			
			if( type.toLowerCase() == "true")
			{
				for(var i:int=0;i<result.Rights[0].children().length();i++)
				{
					var lol:AccessRightDTO = new AccessRightDTO();
					lol.FromXML( result.Rights[0].children()[i] );
					
					model.UserAccessRightDTOList.addItem(lol);
				}
			}
			CursorManager.removeBusyCursor();
		}
		
		private function onError(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			//Alert.show("Received In LoadUserAccessRightCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			var errorStatus:String = "Fault occured in LoadUserAccessRightCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}