package com.adobe.Quivus.command
{
	import com.adobe.Quivus.delegate.LoadUserMostRecentPatientDelegate;
	import com.adobe.Quivus.events.LoadUserMostRecentPatientEvent;
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

	
	public class LoadUserMostRecentPatientCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadUserMostRecentPatientDelegate = new LoadUserMostRecentPatientDelegate( this );
				
				delegate.LoadUserMostRecentPatient(model.loggedInUserDTO.UserId,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var recentPatientResposeDTO:RecentPatientRespose = re.result as RecentPatientRespose;
				
				if(recentPatientResposeDTO!=null)
				{
					if(recentPatientResposeDTO.ResponseStatus)
					{
						model.mostRecentPatientList = recentPatientResposeDTO.MostRecentPatientsResponseData.RecentPatientList;
						model.totalRecords_RP 		= recentPatientResposeDTO.MostRecentPatientsResponseData.TotalRecords;
						LoadUserMostRecentPatientEvent.isAlreadyLoaded = true;
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(recentPatientResposeDTO.ResponseCode);
						if(valid)
							Alert.show("LoadUserMostRecentPatient"+"\n"+recentPatientResposeDTO.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadUserMostRecentPatient"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadUserMostRecentPatientCommand.";
				//Alert.show("Fault occured in LoadUserMostRecentPatientCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadUserMostRecentPatientCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}