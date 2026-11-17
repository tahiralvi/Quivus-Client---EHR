package com.adobe.Quivus.command.visit
{
	import com.adobe.Quivus.delegate.visit.CreateVisitDelegate;
	import com.adobe.Quivus.events.visit.LoadVisitPhysiciansbyClinicBranchIDEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.DTOInitializationUtility;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class CreateVisitCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : CreateVisitDelegate = new CreateVisitDelegate( this );
				
				model.visitDTO =  DTOInitializationUtility.createVisitDTO(0,model.generalTemplateId);
				
				if(model.userSelectedRoleDTO.UserTypeRole.IsProvider)
				{
					model.visitDTO.OwnerId = model.loggedInUserDTO.UserId;
					model.visitDTO.OwnerUserType= new UserTypeDTO();
					model.visitDTO.OwnerUserType.UserTypeId = model.userSelectedRoleDTO.UserTypeRole.UserTypeId;
				}
				
				delegate.CreateNewVisit(model.visitDTO,model.loggedInUserDTO.UserId,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var createVisitResponse:CreateVisitResponse  = re.result as CreateVisitResponse ;
				if(createVisitResponse!=null)
				{
					if(createVisitResponse.ResponseStatus)
					{
						if(createVisitResponse.VisitId>0)
						{
							model.visitId = createVisitResponse.VisitId;
							model.visitDTO.VisitId = 	createVisitResponse.VisitId;					
							
							//Tahir Alvi - for provider
							var gueEvent : LoadVisitPhysiciansbyClinicBranchIDEvent = new LoadVisitPhysiciansbyClinicBranchIDEvent(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, 
																							model.visitDTO.VisitId, model.patientDTO.PatientId, false, model.loggedInUserDTO.UserId);
							CairngormEventDispatcher.getInstance().dispatchEvent( gueEvent );
							
							
							//DTOInitializationUtility.initializeQuickInputDTO();
							/*if(model.visitDTO!=null)
							{
								if(model.encounterTypeDTOList!=null && model.encounterTypeDTOList.length>0)
								{
									model.visitDTO.EncounterTypeId = (model.encounterTypeDTOList.getItemAt(0) as EncounterTypeDTO).VisitEncounterTypeID;
								}
							}*/
							
							model.chdataLoaded = true;
						}
						else
						{
							Alert.show("CreateVisit"+"\n"+Messages.VISIT_NOT_CREATED, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						model.errorStatus = createVisitResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(createVisitResponse.ResponseCode);
						if(valid)
							Alert.show("CreateVisit"+"\n"+createVisitResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("CreateVisit"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in CreateVisitCommand.";
			//	Alert.show("Fault occured in CreateVisitCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in CreateVisitCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}