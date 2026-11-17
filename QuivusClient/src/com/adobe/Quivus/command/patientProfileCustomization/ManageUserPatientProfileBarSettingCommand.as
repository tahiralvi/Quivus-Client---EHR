package com.adobe.Quivus.command.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.patientProfileCustomization.ManageUserPatientProfileBarSettingDelegate;
	import com.adobe.Quivus.events.patientProfileCustomization.LoadPatientProfileCustomizedSettingEvent;
	import com.adobe.Quivus.events.patientProfileCustomization.ManageUserPatientProfileBarSettingEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
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

	
	public class ManageUserPatientProfileBarSettingCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var setAsDefault		: Boolean;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : ManageUserPatientProfileBarSettingDelegate = new ManageUserPatientProfileBarSettingDelegate( this );
				var LE:ManageUserPatientProfileBarSettingEvent = cgEvent as ManageUserPatientProfileBarSettingEvent;
				this.setAsDefault = LE.setAsDefault;
				
				if( LE.sectionNo>0 && LE.userProfileCategoryId>0){
					var profileSettingObj:PatientProfileSettingDTO = new PatientProfileSettingDTO();
					
					profileSettingObj.ClinicBranchID 			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
					profileSettingObj.UserUserProfileCategoryID = LE.userUserProfileCategoryId;
					profileSettingObj.ModifiedBy 				= model.loggedInUserDTO.UserId;
					profileSettingObj.CreatedBy 				= model.loggedInUserDTO.UserId;
					profileSettingObj.UserID 					= model.loggedInUserDTO.UserId;
					profileSettingObj.SectionNo 				= LE.sectionNo;
					profileSettingObj.UserProfileCategoryID 	= LE.userProfileCategoryId;
					profileSettingObj.CreatedAt                	= new Date();
					
					delegate.ManageUserPatientProfileBarSetting(profileSettingObj,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientProfileSettingResponse:PatientProfileSettingResponse = re.result as PatientProfileSettingResponse;
				if(patientProfileSettingResponse!=null)
				{
					if(patientProfileSettingResponse.ResponseStatus)
					{
						model.setAsDefault = this.setAsDefault;
						if(!this.setAsDefault)
						{
							var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(model.loadedPatientId,false);
							CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );					
							
							//manage with old values
							//setFirstSectionOldData();
							//setSecondSectionOldData();
							//setThirdSectionOldData();
						}
						else
						{
							var testEvent : LoadPatientProfileCustomizedSettingEvent = new LoadPatientProfileCustomizedSettingEvent(model.loadedPatientId,true);
							CairngormEventDispatcher.getInstance().dispatchEvent( testEvent );
						}
					}
					else
					{
						model.errorStatus = patientProfileSettingResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(patientProfileSettingResponse.ResponseCode);
						if(valid)
							Alert.show("ManageUserPatientProfileBarSetting"+"\n"+patientProfileSettingResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("ManageUserPatientProfileBarSetting"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
				
		public static function setFirstSectionOldData(  ) : void {		
			var model : AppModelLocator = AppModelLocator.getInstance();
			var profileSettingObj:PatientProfileSettingDTO = new PatientProfileSettingDTO();
			if(model.userSelectedClinicBranchDTO!=null && model.userPatientProfileBarSettingTemp.CompleteSettings.SectionFirstData!=null)
			{
				profileSettingObj.ClinicBranchID 			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				profileSettingObj.UserUserProfileCategoryID = model.userPatientProfileBarSettingTemp.CompleteSettings.SectionFirstData.UserUserProfileCategoryID;
				profileSettingObj.ModifiedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.CreatedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.UserID 					= model.loggedInUserDTO.UserId;
				profileSettingObj.SectionNo 				= model.userPatientProfileBarSettingTemp.CompleteSettings.SectionFirstData.SectionNo;
				profileSettingObj.UserProfileCategoryID 	= model.userPatientProfileBarSettingTemp.CompleteSettings.SectionFirstData.UserProfileCategoryID;
				profileSettingObj.CreatedAt                	= new Date();
				
				(QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance() as Object).ManagePatientProfileSettings(profileSettingObj,model.sessionDTO)
			}
		}
		public static function setSecondSectionOldData(  ) : void {		
			var model : AppModelLocator = AppModelLocator.getInstance();
			var profileSettingObj:PatientProfileSettingDTO = new PatientProfileSettingDTO();
			if(model.userSelectedClinicBranchDTO!=null && model.userPatientProfileBarSettingTemp.CompleteSettings.SectionSecondData!=null)
			{
				profileSettingObj.ClinicBranchID 			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				profileSettingObj.UserUserProfileCategoryID = model.userPatientProfileBarSettingTemp.CompleteSettings.SectionSecondData.UserUserProfileCategoryID;
				profileSettingObj.ModifiedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.CreatedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.UserID 					= model.loggedInUserDTO.UserId;
				profileSettingObj.SectionNo 				= model.userPatientProfileBarSettingTemp.CompleteSettings.SectionSecondData.SectionNo;
				profileSettingObj.UserProfileCategoryID 	= model.userPatientProfileBarSettingTemp.CompleteSettings.SectionSecondData.UserProfileCategoryID;
				profileSettingObj.CreatedAt                	= new Date();
				
				(QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance() as Object).ManagePatientProfileSettings(profileSettingObj,model.sessionDTO)
			}
		}
		public static function setThirdSectionOldData(  ) : void {		
			var model : AppModelLocator = AppModelLocator.getInstance();
			var profileSettingObj:PatientProfileSettingDTO = new PatientProfileSettingDTO();
			if(model.userSelectedClinicBranchDTO!=null && model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData!=null)
			{
				profileSettingObj.ClinicBranchID 			= model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				profileSettingObj.UserUserProfileCategoryID = model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.UserUserProfileCategoryID;
				profileSettingObj.ModifiedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.CreatedBy 				= model.loggedInUserDTO.UserId;
				profileSettingObj.UserID 					= model.loggedInUserDTO.UserId;
				profileSettingObj.SectionNo 				= 3;
				profileSettingObj.CreatedAt                	= new Date();
				
				if( model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.CollectionType == Constants.ALLERGIES_CATEGORY_NAME)
				{
					profileSettingObj.UserProfileCategoryID 	= Constants.ALLERGIES_CATEGORY_ID;				
				}
				else if(model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.CollectionType == Constants.DIAGNOSIS_CATEGORY_NAME)
				{
					profileSettingObj.UserProfileCategoryID 	= Constants.DIAGNOSIS_CATEGORY_ID;
				}
				else if(model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.CollectionType == Constants.IMMUNIZATION_CATEGORY_NAME)
				{
					profileSettingObj.UserProfileCategoryID 	= Constants.IMMUNIZATION_CATEGORY_ID;
				}
				else if(model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.CollectionType == Constants.CHRONIC_MEDICATION_CATEGORY_NAME)
				{
					profileSettingObj.UserProfileCategoryID 	= Constants.CHRONIC_MEDICATION_CATEGORY_ID;
				}
				else if(model.userPatientProfileBarSettingTemp.CompleteSettings.SectionThirdData.CollectionType == Constants.INSURANCE_CATEGORY_NAME)
				{
					profileSettingObj.UserProfileCategoryID 	= Constants.INSURANCE_CATEGORY_ID;
				}
				
				(QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance() as Object).ManagePatientProfileSettings(profileSettingObj,model.sessionDTO)
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in ManageUserPatientProfileBarSettingCommand.";
			//	Alert.show("Fault occured in ManageUserPatientProfileBarSettingCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in ManageUserPatientProfileBarSettingCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
				
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}