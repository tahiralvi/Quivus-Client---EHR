package com.adobe.Quivus.command.staticData.registration
{
	import com.adobe.Quivus.delegate.staticData.registration.LoadRegistrationStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.registration.LoadRegistrationStaticDataEvent;
	import com.adobe.Quivus.events.staticData.registration.LoadSpecifiedRegistrationStaticDataEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.sql.PersistanceUtility;
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

	
	public class LoadSpecifiedRegistrationStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var dataToLoad:ArrayCollection ; 
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadRegistrationStaticDataDelegate = new LoadRegistrationStaticDataDelegate( this );
				var LE:LoadSpecifiedRegistrationStaticDataEvent = cgEvent as LoadSpecifiedRegistrationStaticDataEvent;
				
				if(perUtil.isRegisterationLocalDBAvaliable())
				{
					this.dataToLoad = LE.dataToLoad;
					
					if(!model.registrationStaticDataDTO)
						model.registrationStaticDataDTO = new RegisterationStaticDataDTO();
					
					perUtil.loadSpecifiedRegisterationData(this.dataToLoad);
				}
				else if(LE.dataToLoad!=null && LE.dataToLoad.length>0)
				{
					this.dataToLoad = LE.dataToLoad;
					delegate.LoadRegistrationStaticData(LE.dataToLoad,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var regStaticDataResponseDTO:RegistrationStaticDataResponse = re.result as RegistrationStaticDataResponse;
			
				if(regStaticDataResponseDTO.ResponseStatus)
				{
					if(regStaticDataResponseDTO.ResponseData!=null){
						//model.registrationStaticDataDTO = regStaticDataResponseDTO.ResponseData as RegisterationStaticDataDTO;					
						
						if(model.registrationStaticDataDTO == null)
						{
							model.registrationStaticDataDTO = new RegisterationStaticDataDTO();
						}
						
						if(this.dataToLoad.contains(Constants.PREFIX_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.PrefixTypes = regStaticDataResponseDTO.ResponseData.PrefixTypes;
						}
						else if(this.dataToLoad.contains(Constants.GENDER_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.GenderTypes = regStaticDataResponseDTO.ResponseData.GenderTypes;
						}
						else if(this.dataToLoad.contains(Constants.MARITAL_STATUS_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.MaritalStatusTypes = regStaticDataResponseDTO.ResponseData.MaritalStatusTypes;
						}
						else if(this.dataToLoad.contains(Constants.LANGUAGE_ABILITY_MODE_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.LanguageAbilityModeDTOList = regStaticDataResponseDTO.ResponseData.LanguageAbilityModeDTOList;
						}
						else if(this.dataToLoad.contains(Constants.INSURANCE_NATURE_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.InsuranceNatureTypes = regStaticDataResponseDTO.ResponseData.InsuranceNatureTypes;
						}
						else if(this.dataToLoad.contains(Constants.INSURANCE_ORGANIZATION_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.InsuranceOrganizations = regStaticDataResponseDTO.ResponseData.InsuranceOrganizations;
						}
						else if(this.dataToLoad.contains(Constants.SMOKING_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.SmokingTyeDTOList = regStaticDataResponseDTO.ResponseData.SmokingTyeDTOList;
						}
						else if(this.dataToLoad.contains(Constants.INSURANCE_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.InsuranceTypes = regStaticDataResponseDTO.ResponseData.InsuranceTypes;
						}
						else if(this.dataToLoad.contains(Constants.STATUS_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.AllStatusTypeList = regStaticDataResponseDTO.ResponseData.AllStatusTypeList;
						}
						else if(this.dataToLoad.contains(Constants.USER_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.UserTypes = regStaticDataResponseDTO.ResponseData.UserTypes;
						}
						else if(this.dataToLoad.contains(Constants.ETHINICITY_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.EthinicityTypes = regStaticDataResponseDTO.ResponseData.EthinicityTypes;
						}
						else if(this.dataToLoad.contains(Constants.RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.RelationshipTypes = regStaticDataResponseDTO.ResponseData.RelationshipTypes;
						}
						else if(this.dataToLoad.contains(Constants.BLOOD_RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.BloodRelationshipTypes = regStaticDataResponseDTO.ResponseData.BloodRelationshipTypes;
						}
						else if(this.dataToLoad.contains(Constants.RACE_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.RaceTypes = regStaticDataResponseDTO.ResponseData.RaceTypes;
						}					
						else if(this.dataToLoad.contains(Constants.OCCUPATION_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.OccupationTypes = regStaticDataResponseDTO.ResponseData.OccupationTypes;
						}
						else if(this.dataToLoad.contains(Constants.LANGUAGE_TYPE_REGISTERATION_STATIC_DATA))
						{
							model.registrationStaticDataDTO.LanguageTypes = regStaticDataResponseDTO.ResponseData.LanguageTypes;
						}
					}
					else
					{
						Alert.show(Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
			}
		}
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadSpecifiedRegistrationStaticDataCommand.";
			//	Alert.show("Fault occured in LoadSpecifiedRegistrationStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadSpecifiedRegistrationStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}