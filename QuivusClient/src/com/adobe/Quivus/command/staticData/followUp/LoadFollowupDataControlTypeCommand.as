package com.adobe.Quivus.command.staticData.followUp
{
	
	
	import com.adobe.Quivus.delegate.staticData.followUp.LoadFollowupDataControlTypeDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.sql.PersistanceUtility;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadFollowupDataControlTypeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadFollowupDataControlTypeDelegate = new  LoadFollowupDataControlTypeDelegate(this);
				 
				delegate.LoadFollowupDataControlType(model.sessionDTO);
				 
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:FollowupDataControlTypeResponse = re.result as FollowupDataControlTypeResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.ResponseData !=null){
	
							model.followupDataControlTypeDTOList = resp.ResponseData;
							
							var i:int;
							var dto:FollowupDataControlTypeDTO;
							for(i=0;i<model.followupDataControlTypeDTOList.length;i++)
							{
								dto= model.followupDataControlTypeDTOList.getItemAt(i) as FollowupDataControlTypeDTO;
								
								if(dto.DataControlName  == Constants.FOLLOW_UP_SERVICE_CONTROL_NAME)
								{
									model.followupServiceTypeControlId = dto.FollowupDataControlTypeID;
								}
								
							}
						}
						else
						{
							Alert.show("LoadFollowupDataControlType"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadFollowupDataControlType"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadFollowupDataControlType"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadFollowupDataControlTypeCommand.";
			//	Alert.show("Fault occured in LoadFollowupDataControlTypeCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadFollowupDataControlTypeCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}