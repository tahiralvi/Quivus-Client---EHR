package com.adobe.Quivus.command.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.patientProfileCustomization.LoadPatientHistoryPopupDataDelegate;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientHistoryPopupDataEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadPatientHistoryPopupDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var dataToLoad: String;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientHistoryPopupDataDelegate = new LoadPatientHistoryPopupDataDelegate( this );
				var LE:LoadPatientHistoryPopupDataEvent = cgEvent as LoadPatientHistoryPopupDataEvent;
				this.dataToLoad = LE.dataToLoad;
				if(LE.dataToLoad!=null && LE.dataToLoad.length>0){
					delegate.LoadPatientHistoryPopupData(model.loadedPatientId,LE.dataToLoad,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{	
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				
				if(this.dataToLoad == Constants.ALLERGIES_CATEGORY_NAME)
				{
					var patientProfileAllergyResponse:PatientProfileAllergyResponse = re.result as PatientProfileAllergyResponse;
					if(patientProfileAllergyResponse.ResponseStatus)
					{
						model.patientAllergyInfoDTOList = patientProfileAllergyResponse.PatientProfileAllergy.PatientAllergyInfoData;
					}
				}
				else if(this.dataToLoad == Constants.DIAGNOSIS_CATEGORY_NAME)
				{
					var patientProfileDiagnosisResponse:PatientProfileDiagnosisResponse = re.result as PatientProfileDiagnosisResponse;
					if(patientProfileDiagnosisResponse.ResponseStatus)
					{
						model.patientDiagnosisInfoDTOList = patientProfileDiagnosisResponse.ProfileDiagnosis.PatientDiagnosisInfoData;
					}
				}
				else if(this.dataToLoad == Constants.IMMUNIZATION_CATEGORY_NAME)
				{
					var patientProfileImmunizationResponse:PatientProfileImmunizationResponse = re.result as PatientProfileImmunizationResponse;
					if(patientProfileImmunizationResponse.ResponseStatus)
					{
						model.patientImmunizationInfoDTOList = patientProfileImmunizationResponse.ProfileImmunizationDTO.PatientImmunizationInfoData;
					}
				}
				else if(this.dataToLoad == Constants.CHRONIC_MEDICATION_CATEGORY_NAME)
				{
					var patientProfileChronicMedicationResponse:PatientProfileChronicMedicationResponse = re.result as PatientProfileChronicMedicationResponse;
					if(patientProfileChronicMedicationResponse.ResponseStatus)
					{
						model.patientChronicMedicationInfoDTOList = patientProfileChronicMedicationResponse.PatientProfileChronicMedication.PatientChronicMedicationInfoData;
					}
				}
				else if(this.dataToLoad == Constants.INSURANCE_CATEGORY_NAME)
				{
					var patientProfileInsuranceResponse:PatientProfileInsuranceResponse = re.result as PatientProfileInsuranceResponse;
					if(patientProfileInsuranceResponse.ResponseStatus)
					{
						model.patientInsuracneInfoDTOList = patientProfileInsuranceResponse.ProfileInsuranceDTO.PatientInsuranceInfoData;
					}
				}
			}
		}
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientHistoryPopupDataCommand.";
			//	Alert.show("Fault occured in LoadPatientHistoryPopupDataCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientHistoryPopupDataCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}