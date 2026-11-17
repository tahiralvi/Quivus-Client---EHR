package com.adobe.Quivus.command.viewBackground.followUp
{
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.followUp.ManagePatientFollowUpDelegate;
	import com.adobe.Quivus.events.viewBackground.followUp.LoadPatientFollowUpInstructionByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
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
	
	
	public class  ManagePatientFollowUpCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate :  ManagePatientFollowUpDelegate = new  ManagePatientFollowUpDelegate( this );
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				if(model.patientFollowupDTOListByPatientId!=null)
				{				
					var newList:ArrayCollection = new ArrayCollection();
					model.patientFollowupDTOListByPatientId.filterFunction = null;
					model.patientFollowupDTOListByPatientId.refresh();
					
					for(var i:int=0;i<model.patientFollowupDTOListByPatientId.length;i++)
					{
						var dto:PatientFollowUpDTO = model.patientFollowupDTOListByPatientId.getItemAt(i) as PatientFollowUpDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;		
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					if(newList.length>0)
						delegate.ManagePatientFollowUp(newList, model.sessionDTO);
				}
				
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp: PatientFollowUpResponse   = re.result as  PatientFollowUpResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						
						
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientFollowUp"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientFollowUp"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in ManagePatientFollowUpCommand.";
			//Alert.show("Fault occured in ManagePatientFollowUpCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientFollowUpCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}