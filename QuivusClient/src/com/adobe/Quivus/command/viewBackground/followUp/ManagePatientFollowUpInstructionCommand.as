package com.adobe.Quivus.command.viewBackground.followUp
{
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.ManagePatientFollowUpDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.ManagePatientFollowUpInstructionDelegate;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class  ManagePatientFollowUpInstructionCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate :  ManagePatientFollowUpInstructionDelegate = new  ManagePatientFollowUpInstructionDelegate( this );
				
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				if(model.patientFollowupInstructionDTOListByPatient!=null)
				{				
					var i:int;
					
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.patientFollowupInstructionDTOListByPatient.length;i++)
					{
						var dto:PatientFollowupInstructionDTO = model.patientFollowupInstructionDTOListByPatient.getItemAt(i) as PatientFollowupInstructionDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					if(newList.length>0)
						delegate.ManagePatientFollowUpInstruction(newList, model.sessionDTO);
				}
				
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp: PatientFollowupInstructionResponse   = re.result as  PatientFollowupInstructionResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lpfip:LoadPatientFollowUpInstructionByPatientIdEvent = new LoadPatientFollowUpInstructionByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpfip );
						
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientFollowUpInstruction"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientFollowUpInstruction"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in ManagePatientFollowUpInstructionCommand.";
			//Alert.show("Fault occured in ManagePatientFollowUpInstructionCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientFollowUpInstructionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}