package com.adobe.Quivus.command.search
{
	import com.adobe.Quivus.delegate.search.PatientSearchDelegate;
	import com.adobe.Quivus.events.search.PatientSearchEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class PatientSearchCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : PatientSearchDelegate = new PatientSearchDelegate( this );
				var LE:PatientSearchEvent = cgEvent as PatientSearchEvent;
				this.functionName = LE.functionName;
				trace("Search String ::"+LE.searchString);
				delegate.PatientSearch( model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
										model.userSelectedRoleDTO.UserTypeProfileID,
										model.userSelectedRoleDTO.UserTypeRole.UserTypeId,
										LE.searchString,
										model.patientSearchPageNo,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientSearchResponseDTO:PatientSearchResponse = re.result as PatientSearchResponse;
				
				if(patientSearchResponseDTO!=null)
				{
					if(patientSearchResponseDTO.ResponseStatus)
					{
						model.patientSearchResultDTO = patientSearchResponseDTO.PatientSearchResultResponseData;
						model.patientSearchDTOList   = patientSearchResponseDTO.PatientSearchResultResponseData.PatientSearchList;
						if(this.functionName!=null)
						{
							this.functionName(model.patientSearchDTOList);
						}
					}
					else
					{
						model.errorStatus = patientSearchResponseDTO.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(patientSearchResponseDTO.ResponseCode);
						if(valid)
							Alert.show("PatientSearch"+"\n"+patientSearchResponseDTO.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("PatientSearch"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in PatientSearchCommand.";
				//Alert.show("Fault occured in PatientSearchCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in PatientSearchCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}