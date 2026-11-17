package com.adobe.Quivus.command.quickInput.diagnosis
{	
	import com.adobe.Quivus.delegate.quickInput.diagnosis.LoadDiagnosisForRecommendationByPatientIdDelegate;
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
	
	
	public class LoadDiagnosisForRecommendationByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadDiagnosisForRecommendationByPatientIdDelegate = new LoadDiagnosisForRecommendationByPatientIdDelegate( this );
				
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				
				
				delegate.LoadDiagnosisForRecommendationByPatientId(model.loadedPatientId,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientDiagnosisResponse  = re.result as PatientDiagnosisResponse ;
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
							model.patientAllDiagnosisForRecommendationList = resp.PatientDiagnosisList;
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
							Alert.show("LoadDiagnosisForRecommendationByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadDiagnosisForRecommendationByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoadDiagnosisForRecommendationByPatientIdCommand.";
			//Alert.show("Fault occured in LoadDiagnosisForRecommendationByPatientIdCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadDiagnosisForRecommendationByPatientIdCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}