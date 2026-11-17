package com.adobe.Quivus.command.staticData.followUp
{
	
	
	import com.adobe.Quivus.delegate.staticData.followUp.LoadServiceTypeDelegate;
	import com.adobe.Quivus.events.staticData.followUp.LoadServiceTypeEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
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

	
	public class LoadServiceTypeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		var LE:LoadServiceTypeEvent
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				LE = cgEvent as LoadServiceTypeEvent;
				
				 var delegate:LoadServiceTypeDelegate = new  LoadServiceTypeDelegate(this);
				 delegate.LoadServiceType(LE.followupDataControlTypeID, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:ServiceTypeResponse  = re.result as ServiceTypeResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.ServiceTypeList!=null && LE.followupDataControlTypeID == model.followupServiceTypeControlId)
						{
							model.serviceTypeDTOList = resp.ServiceTypeList;
						}
						else if(resp.ServiceTypeList!=null && LE.followupDataControlTypeID == model.followupDateTypeControlId)
						{
							model.DateServiceTypeDTOList = resp.ServiceTypeList;
						}
						else
						{
							Alert.show("LoadServiceType"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadServiceType"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadServiceType"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadServiceTypeCommand.";
			//	Alert.show("Fault occured in LoadServiceTypeCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadServiceTypeCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}