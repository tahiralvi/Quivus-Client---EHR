package com.adobe.Quivus.command.ePrescription
{
	import com.adobe.Quivus.delegate.ePrescription.SyncEPrescriptionDelegate;
	import com.adobe.Quivus.events.ePrescription.SyncEPrescriptionEvent;
	import com.adobe.Quivus.events.viewBackground.allergy.LoadPatientAllergyByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.prescription.LoadPatientPrescriptionByPatientIdEvent;
	import com.adobe.Quivus.events.viewBackground.prescription.LoadPrescriptionMedicationByPatientPrescriptionIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SyncEPrescriptionCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SyncEPrescriptionDelegate = new SyncEPrescriptionDelegate( this );
				
				var LE:SyncEPrescriptionEvent = cgEvent as SyncEPrescriptionEvent;
				
				delegate.SyncEPrescriptionWithEPresService(LE.visitId,model.loadedPatientId,Constants.EMPTY_STRING,model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,model.sessionDTO);
				
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:ServiceResponse  = re.result as ServiceResponse;
				
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						//change the call with respective page set with default values;
						if( UtilityFunctions.IsNullOrEmpty( model.allergyCurrentPageByPatient ) )
						{
							model.allergyCurrentPageByPatient = new PageDTO();
						}
						
						if( UtilityFunctions.IsNullOrEmpty( model.medicationCurrentPageByPatient ) )
						{
							model.medicationCurrentPageByPatient = new PageDTO();
						}
						
						if( UtilityFunctions.IsNullOrEmpty( model.prescriptionCurrentPageByPatient ) )
						{
							model.prescriptionCurrentPageByPatient = new PageDTO();
						}
						
						
						QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.allergyCurrentPageByPatient );
						QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.medicationCurrentPageByPatient );
						QSUtilityFunctions.CheckUserPageOrSetPageToZero( model.prescriptionCurrentPageByPatient );
						//End change the call
						
						
						var lpaEvent : LoadPatientAllergyByPatientIdEvent = new LoadPatientAllergyByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lpaEvent );
						
						
						//chronic medication
						var lppbpEvent : LoadPatientPrescriptionByPatientIdEvent = new LoadPatientPrescriptionByPatientIdEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent( lppbpEvent );
						
						
						//prescription - prescriptionMedicationDTOList
						var lpmbpp:LoadPrescriptionMedicationByPatientPrescriptionIdEvent = new LoadPrescriptionMedicationByPatientPrescriptionIdEvent(/*model.loadedPatientId*/);
						CairngormEventDispatcher.getInstance().dispatchEvent( lpmbpp );
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("SyncEPrescription"+"\n"+resp.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("SyncEPrescription"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SyncEPrescriptionCommand.";
			//	Alert.show("Fault occured in SyncEPrescriptionCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in SyncEPrescriptionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}