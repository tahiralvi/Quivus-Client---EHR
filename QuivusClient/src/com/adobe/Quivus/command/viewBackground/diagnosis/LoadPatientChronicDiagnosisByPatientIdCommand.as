package com.adobe.Quivus.command.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.viewBackground.diagnosis.LoadPatientChronicDiagnosisByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdDelegate;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdEvent;
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
	
	
	public class LoadPatientChronicDiagnosisByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientChronicDiagnosisByPatientIdDelegate = new LoadPatientChronicDiagnosisByPatientIdDelegate( this );
				
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				
				
				delegate.LoadPatientChronicDiagnosisByPatientId(model.loadedPatientId, 
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO,model.stationIdsForVB,model.isAllStationSelected);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientDiagnosisResponse   = re.result as PatientDiagnosisResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.PatientDiagnosisList!=null)
						{
							model.patientChronicDiagnosisDTOListByPatientId = resp.PatientDiagnosisList;							
						}
						else
						{
							Alert.show("LoadPatientChronicDiagnosisByPatientId"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientChronicDiagnosisByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientChronicDiagnosisByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoadPatientChronicDiagnosisByPatientIdCommand.";
		//	Alert.show("Fault occured in LoadPatientChronicDiagnosisByPatientIdCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientChronicDiagnosisByPatientIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}