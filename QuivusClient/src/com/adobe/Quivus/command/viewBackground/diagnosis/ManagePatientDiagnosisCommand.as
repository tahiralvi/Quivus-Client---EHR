package com.adobe.Quivus.command.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.viewBackground.diagnosis.ManagePatientDiagnosisDelegate;
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
	
	
	public class ManagePatientDiagnosisCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManagePatientDiagnosisDelegate = new ManagePatientDiagnosisDelegate( this );
				
				//var LE:LoadPatientFollowUpInstructionByVisitIdEvent = cgEvent as LoadPatientFollowUpInstructionByVisitIdEvent;
				
				//-- Tahir Alvi -- diagnosis
				if(model.patientDiagnosisDTOListByPatientId!=null)
				{				
					var i:int;
					var newList:ArrayCollection = new ArrayCollection();
					
					if(model.patientDiagnosisDTOListByPatientId!=null)
					{
						model.patientDiagnosisDTOListByPatientId.filterFunction = null;
						model.patientDiagnosisDTOListByPatientId.refresh();
						
						for(i=0;i<model.patientDiagnosisDTOListByPatientId.length;i++)
						{
							var dto:PatientDiagnosisDTO = model.patientDiagnosisDTOListByPatientId.getItemAt(i) as PatientDiagnosisDTO;
							if(dto.IsDeleted == true || dto.IsDirty == true)
							{
								dto.ModifiedBy = model.loggedInUserDTO.UserId;			
								dto.ModifiedAt = new Date();
								newList.addItem(dto);
							}
						}
					}
					
					//-- Tahir Alvi -- acute diagnosis
					if(model.patientDiagnosisDTOAcuteListByPatientId !=null )
					{
						model.patientDiagnosisDTOAcuteListByPatientId.filterFunction = null;
						model.patientDiagnosisDTOAcuteListByPatientId.refresh();
						
						for(i=0;i<model.patientDiagnosisDTOAcuteListByPatientId.length;i++)
						{
							var dto:PatientDiagnosisDTO = model.patientDiagnosisDTOAcuteListByPatientId.getItemAt(i) as PatientDiagnosisDTO;
							if(dto.IsDeleted == true || dto.IsDirty == true)
							{
								dto.ModifiedBy = model.loggedInUserDTO.UserId;			
								dto.ModifiedAt = new Date();
								newList.addItem(dto);
							}
						}
					}
					//-- Tahir Alvi (End)-- acute diagnosis
					//chronic
					if(model.patientDiagnosisDTOChronicListByPatientId != null)
					{
						model.patientDiagnosisDTOChronicListByPatientId.filterFunction = null;
						model.patientDiagnosisDTOChronicListByPatientId.refresh();
						for(i=0;i<model.patientDiagnosisDTOChronicListByPatientId.length;i++)
						{
							var dto:PatientDiagnosisDTO = model.patientDiagnosisDTOChronicListByPatientId.getItemAt(i) as PatientDiagnosisDTO;
							if(dto.IsDeleted == true || dto.IsDirty == true)
							{
								dto.ModifiedBy = model.loggedInUserDTO.UserId;			
								dto.ModifiedAt = new Date();
								newList.addItem(dto);
							}
							
						}
					}
					
					
					if(newList.length>0)
						delegate.ManagePatientDiagnosis(newList,model.sessionDTO, model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq, model.loadedPatientId);
				}
				
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
						//Tahir Alvi - New implementation
						Alert.show('Record saved successfully', 'Info',4,FlexGlobals.topLevelApplication.mainContainer);
						
						//now there are three calls
						/*var lpviEvent: LoadPatientDiagnosisByPatientIdEvent = new LoadPatientDiagnosisByPatientIdEvent(); 
						CairngormEventDispatcher.getInstance().dispatchEvent( lpviEvent );*/
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("ManagePatientDiagnosis"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManagePatientDiagnosis"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in ManagePatientDiagnosisCommand.";
			//	Alert.show("Fault occured in ManagePatientDiagnosisCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in ManagePatientDiagnosisCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}