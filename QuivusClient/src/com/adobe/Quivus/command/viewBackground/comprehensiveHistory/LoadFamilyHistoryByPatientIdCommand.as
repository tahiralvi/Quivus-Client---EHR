package com.adobe.Quivus.command.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.LoadFamilyHistoryByPatientIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.LoadPatientFamilyHistoryByVisitIdDelegate;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadPatientFamilyHistoryByVisitIdEvent;
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

	
	public class LoadFamilyHistoryByPatientIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadFamilyHistoryByPatientIdDelegate = new LoadFamilyHistoryByPatientIdDelegate( this );
				
				//var LE:LoadPatientFamilyHistoryByVisitIdEvent = cgEvent as LoadPatientFamilyHistoryByVisitIdEvent;
				
				delegate.LoadFamilyHistoryByPatientId(model.loadedPatientId,
					model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO,
				model.stationIdsForVB,model.isAllStationSelected,
				model.familyHistoryCurrentPageByPatient
				);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientFamilyHistoryResponse  = re.result as PatientFamilyHistoryResponse ;
				
				model.vbEventCounter = model.vbEventCounter - 1;
				
				if(model.vbEventCounter == 0){
					
					model.vbDataLoadedFlag=true;
				}
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.familyHistoryDTOListByPatient = resp.ResponseList;	
						model.familyHistoryCurrentPageByPatient = resp.Page;
						if(model.registrationStaticDataDTO != null && model.registrationStaticDataDTO.RelationshipTypes!=null)
						{
							if(model.familyHistoryDTOListByPatient != null )
							{
								var i:int=0;
								for(;i<model.familyHistoryDTOListByPatient.length;i++)
								{
									var dto:FamilyHistoryDTO = model.familyHistoryDTOListByPatient.getItemAt(i) as FamilyHistoryDTO;
									
									var j:int=0;
									for(;j<model.registrationStaticDataDTO.RelationshipTypes.length;j++)
									{
										var r_dto:RelationshipTypeDTO = model.registrationStaticDataDTO.RelationshipTypes.getItemAt(j) as RelationshipTypeDTO; 
										if(r_dto.RelationshipId == dto.ReletionshipTypeID)
										{
											dto.ReletionshipTypeName = r_dto.RelationshipName;
											break;
										}	
										
									}
									
								}
								
								
							}
							
						}
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadFamilyHistoryByPatientId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadFamilyHistoryByPatientId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadFamilyHistoryByPatientIdCommand.";
				//Alert.show("Fault occured in LoadFamilyHistoryByPatientIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadFamilyHistoryByPatientIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}