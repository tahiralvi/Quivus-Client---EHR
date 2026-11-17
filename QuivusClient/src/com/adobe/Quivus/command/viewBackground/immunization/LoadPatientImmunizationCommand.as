package com.adobe.Quivus.command.viewBackground.immunization
{
	import com.adobe.Quivus.delegate.viewBackground.immunization.LoadPatientImmunizationDelegate;
	import com.adobe.Quivus.events.viewBackground.immunization.LoadPatientImmunizationEvent;
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

	
	public class LoadPatientImmunizationCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientImmunizationDelegate = new LoadPatientImmunizationDelegate( this );
				var LE:LoadPatientImmunizationEvent = cgEvent as LoadPatientImmunizationEvent;
							
				if(LE.patientId>0)
				{
					delegate.LoadPatientImmunization(LE.patientId,
						model.loggedInUserDTO.UserId,
						model.userSelectedRoleDTO.UserTypeRole.UserTypeId,
						model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
						model.sessionDTO,
						model.stationIdsForVB,
						model.isAllStationSelected,
						model.immunizationCurrentPageByPatient
					);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientImmunizationResponse:PatientImmunizationResponse    = re.result as PatientImmunizationResponse ;
				
				model.vbEventCounter= model.vbEventCounter - 1;
				
				if(model.vbEventCounter == 0){
					
					model.vbDataLoadedFlag=true;
				}
				if(patientImmunizationResponse!=null){
					if(patientImmunizationResponse.ResponseStatus)
					{
						
						if(model.immunizationDTOList!=null)
							model.immunizationDTOList.removeAll();
						
						model.immunizationDTOList = patientImmunizationResponse.PatientImmunizationData;
						model.immunizationCurrentPageByPatient = patientImmunizationResponse.Page;
						/*var immList:ArrayCollection =  patientImmunizationResponse.PatientImmunizationData;
						if(immList!=null && immList.length>0)
						{
							if(model.immunizationDTOList==null)
								model.immunizationDTOList= new ArrayCollection();
							
							//model.immunizationDTOList.addAll(immList);
							
						}
						model.immunizationDTOList = immList;*/
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(patientImmunizationResponse.ResponseCode);
						if(valid)
							Alert.show("LoadPatientImmunization"+"\n"+patientImmunizationResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientImmunization"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientImmunizationCommand.";
				//Alert.show("Fault occured in LoadPatientImmunizationCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientImmunizationCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}