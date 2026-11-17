package com.adobe.Quivus.command.staticData.registration
{
	import com.adobe.Quivus.delegate.staticData.registration.LoadRegistrationStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.registration.LoadRegistrationStaticDataEvent;
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
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadRegistrationStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadRegistrationStaticDataDelegate = new LoadRegistrationStaticDataDelegate( this );
				var LE:LoadRegistrationStaticDataEvent = cgEvent as LoadRegistrationStaticDataEvent;
				
				if(perUtil.isRegisterationLocalDBAvaliable())
				{
					model.registrationStaticDataDTO = new RegisterationStaticDataDTO();
					
					perUtil.loadRegisterationData();
				}
				else if(LE.dataToLoad!=null && LE.dataToLoad.length>0)
				{
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
						if(model.callNumber ==1){
							model.registrationStaticDataDTO= new RegisterationStaticDataDTO();
							if(model.dataToLoad.contains(Constants.PREFIX_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.PrefixTypes = regStaticDataResponseDTO.ResponseData.PrefixTypes;
							}
							if(model.dataToLoad.contains(Constants.GENDER_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.GenderTypes = regStaticDataResponseDTO.ResponseData.GenderTypes;
							}
							if(model.dataToLoad.contains(Constants.MARITAL_STATUS_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.MaritalStatusTypes = regStaticDataResponseDTO.ResponseData.MaritalStatusTypes;
							}
							if(model.dataToLoad.contains(Constants.LANGUAGE_ABILITY_MODE_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.LanguageAbilityModeDTOList = regStaticDataResponseDTO.ResponseData.LanguageAbilityModeDTOList;
							}
							if(model.dataToLoad.contains(Constants.INSURANCE_NATURE_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.InsuranceNatureTypes = regStaticDataResponseDTO.ResponseData.InsuranceNatureTypes;
							}
							if(model.dataToLoad.contains(Constants.INSURANCE_ORGANIZATION_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.InsuranceOrganizations = regStaticDataResponseDTO.ResponseData.InsuranceOrganizations;
							}
							if(model.dataToLoad.contains(Constants.SMOKING_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.SmokingTyeDTOList = regStaticDataResponseDTO.ResponseData.SmokingTyeDTOList;
							}
							if(model.dataToLoad.contains(Constants.INSURANCE_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.InsuranceTypes = regStaticDataResponseDTO.ResponseData.InsuranceTypes;
							}
							if(model.dataToLoad.contains(Constants.STATUS_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.AllStatusTypeList = regStaticDataResponseDTO.ResponseData.AllStatusTypeList;
							}
							if(model.dataToLoad.contains(Constants.USER_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.UserTypes = regStaticDataResponseDTO.ResponseData.UserTypes;
							}
							model.callNumber=2;
							model.dataToLoad = new ArrayCollection();
							model.dataToLoad.addItem(Constants.ETHINICITY_TYPE_REGISTERATION_STATIC_DATA);
							model.dataToLoad.addItem(Constants.RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA);
							model.dataToLoad.addItem(Constants.BLOOD_RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA);
							var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
							CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
						}
						else if(model.callNumber ==2)
						{
							if(model.dataToLoad.contains(Constants.ETHINICITY_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.EthinicityTypes = regStaticDataResponseDTO.ResponseData.EthinicityTypes;
							}
							if(model.dataToLoad.contains(Constants.RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.RelationshipTypes = regStaticDataResponseDTO.ResponseData.RelationshipTypes;
							}
							if(model.dataToLoad.contains(Constants.BLOOD_RELATIONSHIP_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.BloodRelationshipTypes = regStaticDataResponseDTO.ResponseData.BloodRelationshipTypes;
							}
							model.callNumber=3;
							model.dataToLoad = new ArrayCollection();
							model.dataToLoad.addItem(Constants.RACE_TYPE_REGISTERATION_STATIC_DATA);
							var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
							CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
						}
						else if(model.callNumber ==3)
						{
							if(model.dataToLoad.contains(Constants.RACE_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.RaceTypes = regStaticDataResponseDTO.ResponseData.RaceTypes;
							}
							model.callNumber=4;
							model.dataToLoad = new ArrayCollection();
							model.dataToLoad.addItem(Constants.OCCUPATION_TYPE_REGISTERATION_STATIC_DATA);
							var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
							CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
						}
						else if(model.callNumber ==4)
						{
							if(model.dataToLoad.contains(Constants.OCCUPATION_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.OccupationTypes = regStaticDataResponseDTO.ResponseData.OccupationTypes;
							}
							model.callNumber=5;
							model.dataToLoad = new ArrayCollection();
							model.dataToLoad.addItem(Constants.LANGUAGE_TYPE_REGISTERATION_STATIC_DATA);
							var regSDEvent : LoadRegistrationStaticDataEvent = new LoadRegistrationStaticDataEvent(model.dataToLoad);
							CairngormEventDispatcher.getInstance().dispatchEvent( regSDEvent );
						}
						else if(model.callNumber ==5)
						{
							if(model.dataToLoad.contains(Constants.LANGUAGE_TYPE_REGISTERATION_STATIC_DATA))
							{
								model.registrationStaticDataDTO.LanguageTypes = regStaticDataResponseDTO.ResponseData.LanguageTypes;
							}
							
							perUtil.initializeRegisterationDB();
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
				model.errorStatus = "Fault occured in LoadRegistrationStaticDataCommand.";
			//	Alert.show("Fault occured in LoadRegistrationStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadRegistrationStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}