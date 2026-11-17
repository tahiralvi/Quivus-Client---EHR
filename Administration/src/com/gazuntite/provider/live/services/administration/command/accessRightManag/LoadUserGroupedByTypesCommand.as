package com.gazuntite.provider.live.services.administration.command.accessRightManag
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.provider.live.services.administration.delegate.accessRightManagement.LoadUserGroupedByTypesDelegate;
	import com.gazuntite.provider.live.services.administration.model.AdminAppModelLocator;
	import com.gazuntite.provider.live.services.administration.util.AdminConstant;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.olap.aggregators.CountAggregator;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class LoadUserGroupedByTypesCommand implements Command
	{
		private var model:AdminAppModelLocator = AdminAppModelLocator.getInstance();
		
		private var responder:Responder;
		private var delegate:LoadUserGroupedByTypesDelegate;
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			responder = new Responder(onSuccess, onError);				
			delegate  = new LoadUserGroupedByTypesDelegate( responder );			
			
			delegate.LoadUserGroupedByTypes(model.loggedInUserSelectedBranchId  );
			
		}
		
		private function onSuccess(event:ResultEvent):void
		{
			var re:ResultEvent = event as ResultEvent;
			
			
			var op:ObjectProxy = (re.result as ObjectProxy);
			
			var userGroupedByTypeResponce :ObjectProxy  =  op.UserGroupedByTypeResponce  ;
			if(userGroupedByTypeResponce!=null)
			{
				if(userGroupedByTypeResponce.ResponseStatus)
				{
					model.UserGroupedByRoleList = userGroupedByTypeResponce.GroupedUsers;
					if(model.UserGroupedByRoleList){
						var i:int;
						for(i=0;i<model.UserGroupedByRoleList.length;i++)
						{
							if(model.UserGroupedByRoleList[i].children)
							model.UserGroupedByRoleList[i].children = model.UserGroupedByRoleList[i].children.BaseUserDTO;
							
							
						}
						// Remove the user type from list
						for(i=0;i<model.UserGroupedByRoleList.length;i++)
						{
							if(model.UserGroupedByRoleList[i].UserTypeId == model.loggedInUserProviderTypeId)
							{
								if(model.UserGroupedByRoleList[i].children){
									var j:int;
									for(j=0;j<model.UserGroupedByRoleList[i].children.length;j++)
									{
										if(model.UserGroupedByRoleList[i].children[j].UserId == model.loggedInUserId)
										{
											model.UserGroupedByRoleList[i].children.removeItemAt(j);
											break;											
										}
									}
								}
							}
						}
					}
				}
				else
				{
					Alert.show("LoadUserGroupedByTypes"+"\n"+userGroupedByTypeResponce.ResponseMessage, AdminConstant.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
				
			}
		}
		
		private function onError(event:FaultEvent):void
		{
			//Alert.show("Received In LoadUserGroupedByTypesCommand.\n" + event.toString(), AdminConstant.ERROR, 4, FlexGlobals.topLevelApplication.mainContainer );
			var errorStatus:String = "Fault occured in LoadUserGroupedByTypesCommand.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserId )? -1:model.loggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, event.toString(), userId);
		}
	}
}