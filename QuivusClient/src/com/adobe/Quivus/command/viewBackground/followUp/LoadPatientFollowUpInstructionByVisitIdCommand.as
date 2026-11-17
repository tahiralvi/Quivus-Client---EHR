package com.adobe.Quivus.command.viewBackground.followUp
{
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

	
	public class LoadPatientFollowUpInstructionByVisitIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientFollowUpInstructionByVisitIdDelegate = new LoadPatientFollowUpInstructionByVisitIdDelegate( this );
				
				var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				
				
				delegate.LoadPatientFollowUpInstructionByVisitId(LE.visitId,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientFollowupInstructionResponse   = re.result as PatientFollowupInstructionResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						if(resp.PatientFollowupInstructionList!=null)
						{
							model.patientFollowupInstructionDTOList = resp.PatientFollowupInstructionList;							
						}
						else
						{
							Alert.show("LoadPatientFollowUpInstructionByVisitId"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
						
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientFollowUpInstructionByVisitId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientFollowUpInstructionByVisitId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientFollowUpInstructionByVisitIdCommand.";
				//Alert.show("Fault occured in LoadPatientFollowUpInstructionByVisitIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientFollowUpInstructionByVisitIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}