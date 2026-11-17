package com.adobe.Quivus.command.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.viewBackground.diagnosis.LoadPatientChronicDiagnosisByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.diagnosis.LoadPatientDiagnosisByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdDelegate;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class LoadPatientDiagnosisByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientDiagnosisByPatientIdDelegate = new LoadPatientDiagnosisByPatientIdDelegate( this );
				
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				
				
				delegate.LoadPatientDiagnosisByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.sessionDTO
					,model.stationIdsForVB,model.isAllStationSelected);
				model.vbEventCounter ++ ;
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientAllDiagnosisResponse   = re.result as PatientAllDiagnosisResponse ;
				
				model.vbEventCounter= model.vbEventCounter-1;
				
				if(model.vbEventCounter==0){
					
					model.vbDataLoadedFlag=true;
				}
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						//if(resp.PatientDiagnosisList!=null)
						//{
						if(model.patientDiagnosisDTOAcuteListByPatientId!=null)
							model.patientDiagnosisDTOAcuteListByPatientId.removeAll();
						
						if(model.patientDiagnosisDTOChronicListByPatientId!=null)
							model.patientDiagnosisDTOChronicListByPatientId.removeAll();
						
						if(model.patientDiagnosisDTOResolvedListByPatientId!=null)
							model.patientDiagnosisDTOResolvedListByPatientId.removeAll();
						
						
						
						
						model.patientDiagnosisDTOAcuteListByPatientId 		= resp.PatientAcuteDiagnosisList;	
						model.patientDiagnosisDTOChronicListByPatientId 	= resp.PatientChronicDiagnosisList;	
						model.patientDiagnosisDTOResolvedListByPatientId 	= resp.PatientResolvedDiagnosisList;
						//}
						//else
						//{
						//	Alert.show("LoadPatientAllDiagnosisByPatientId"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						//}
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientDiagnosisByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientDiagnosisByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoadPatientDiagnosisByPatientIdCommand.";
		//	Alert.show("Fault occured in LoadPatientDiagnosisByPatientIdCommand.\n"+rpcEvent.toString());
			//}
			var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientDiagnosisByPatientIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);
		}
	}
}