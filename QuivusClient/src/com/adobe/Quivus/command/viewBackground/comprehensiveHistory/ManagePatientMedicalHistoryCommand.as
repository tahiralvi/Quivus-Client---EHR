package com.adobe.Quivus.command.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.ManagePatientMedicalHistoryDelegate;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadMedicalHistoryByPatientIdEvent;
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

	
	public class ManagePatientMedicalHistoryCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientMedicalHistoryDelegate = new ManagePatientMedicalHistoryDelegate( this );
				
				if(model.medicalHistoryDTOListByPatient!=null)
				{	
					model.medicalHistoryDTOListByPatient.filterFunction =null;
					model.medicalHistoryDTOListByPatient.refresh();
					var i:int;
					
					var newList:ArrayCollection = new ArrayCollection();
					for(i=0;i<model.medicalHistoryDTOListByPatient.length;i++)
					{
						var dto:MedicalHistoryDTO = model.medicalHistoryDTOListByPatient.getItemAt(i) as MedicalHistoryDTO;
						if(dto.IsDeleted == true || dto.IsDirty == true)
						{
							dto.ModifiedBy = model.loggedInUserDTO.UserId;			
							dto.ModifiedAt = new Date();
							newList.addItem(dto);
						}
					}
					if(newList.length>0)
						delegate.ManagePatientMedicalHistory(newList,model.sessionDTO, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.loadedPatientId);
				}
				
				
				
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:PatientMedicalHistoryResponse  = re.result as PatientMedicalHistoryResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						var lmhbpEvent: LoadMedicalHistoryByPatientIdEvent = new LoadMedicalHistoryByPatientIdEvent( ); 
						CairngormEventDispatcher.getInstance().dispatchEvent( lmhbpEvent );
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientMedicalHistory"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientMedicalHistory"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManagePatientMedicalHistoryCommand.";
			//	Alert.show("Fault occured in ManagePatientMedicalHistoryCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientMedicalHistoryCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}