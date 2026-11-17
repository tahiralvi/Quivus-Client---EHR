package com.adobe.Quivus.command.staticData.comprehensiveHistory
{
	
	
	import com.adobe.Quivus.delegate.staticData.comprehensiveHistory.LoadFamilyDiseaseStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.comprehensiveHistory.LoadFamilyDiseaseStaticDataEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
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

	
	public class LoadFamilyDiseaseStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadFamilyDiseaseStaticDataDelegate = new  LoadFamilyDiseaseStaticDataDelegate(this);
				 var LE:LoadFamilyDiseaseStaticDataEvent = cgEvent as LoadFamilyDiseaseStaticDataEvent;
				 if(model.loggedInUserDTO!=null && LE.familyHistoryTypeDTO!=null && LE.familyHistoryTypeDTO.FamilyHistoryTypeID>0)
				 {
					 delegate.LoadFamilyDiseaseStaticData(model.loggedInUserDTO.UserId,
						 								  model.sessionDTO,
														  LE.familyHistoryTypeDTO.FamilyHistoryTypeID);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var diseaseTypeResponse:DiseaseTypeResponse = re.result as DiseaseTypeResponse;
				
				if(diseaseTypeResponse!=null)
				{
					if(diseaseTypeResponse.ResponseStatus)
					{
						
						if(model.diseaseCallNumber ==1)
						{
							
							model.cancerDiseaseTypesDTOList = diseaseTypeResponse.DiseaseList;
							
							perUtil.initializeSpecifiedCompHistoryDB(Constants.FAMILY_CANCER_MODULE_NAME);
							
							model.diseaseCallNumber = 2;
							var diabetesDTO:FamilyHistoryTypeDTO = QSUtilityFunctions.getFamilyHistoryTypeDTOByName(Constants.FAMILY_DIABETES_MODULE_NAME);
							var ldsdEvent : LoadFamilyDiseaseStaticDataEvent = new LoadFamilyDiseaseStaticDataEvent(diabetesDTO);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.diseaseCallNumber ==2)
						{
							model.diabetesDiseaseTypesDTOList = diseaseTypeResponse.DiseaseList;
							
							perUtil.initializeSpecifiedCompHistoryDB(Constants.FAMILY_DIABETES_MODULE_NAME);
							
							model.diseaseCallNumber = 3;
							var heartdiseaseDTO:FamilyHistoryTypeDTO = QSUtilityFunctions.getFamilyHistoryTypeDTOByName(Constants.FAMILY_HEART_DISEASE_MODULE_NAME);
							var ldsdEvent : LoadFamilyDiseaseStaticDataEvent = new LoadFamilyDiseaseStaticDataEvent(heartdiseaseDTO);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.diseaseCallNumber ==3)
						{
							model.heartDiseaseDiseaseTypesDTOList = diseaseTypeResponse.DiseaseList;
							
							perUtil.initializeSpecifiedCompHistoryDB(Constants.FAMILY_HEART_DISEASE_MODULE_NAME);
							
							model.diseaseCallNumber = 4;
							var hypertensionDTO:FamilyHistoryTypeDTO = QSUtilityFunctions.getFamilyHistoryTypeDTOByName(Constants.FAMILY_HYPERTENSION_MODULE_NAME);
							var ldsdEvent : LoadFamilyDiseaseStaticDataEvent = new LoadFamilyDiseaseStaticDataEvent(hypertensionDTO);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}	
						else if(model.diseaseCallNumber ==4)
						{
							model.hypertensionDiseaseTypesDTOList = diseaseTypeResponse.DiseaseList;
							
							perUtil.initializeSpecifiedCompHistoryDB(Constants.FAMILY_HYPERTENSION_MODULE_NAME);
							
							model.diseaseCallNumber = 5;
							var otherDTO:FamilyHistoryTypeDTO = QSUtilityFunctions.getFamilyHistoryTypeDTOByName(Constants.FAMILY_OTHER_MODULE_NAME);
							var ldsdEvent : LoadFamilyDiseaseStaticDataEvent = new LoadFamilyDiseaseStaticDataEvent(otherDTO);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.diseaseCallNumber == 5)
						{
							model.otherDiseaseTypesDTOList = diseaseTypeResponse.DiseaseList;			
							
							perUtil.initializeSpecifiedCompHistoryDB(Constants.FAMILY_OTHER_MODULE_NAME);
							
						}
						
						
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(diseaseTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadFamilyDiseaseStaticData"+"\n"+diseaseTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadFamilyDiseaseStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function InitializeDiseaseLists() : void
		{
			if(model.cancerDiseaseTypesDTOList ==  null)
			{
				model.cancerDiseaseTypesDTOList	= new ArrayCollection();							
			}						
			if(model.diabetesDiseaseTypesDTOList ==  null)
			{
				model.diabetesDiseaseTypesDTOList	= new ArrayCollection();							
			}						
			if(model.heartDiseaseDiseaseTypesDTOList ==  null)
			{
				model.heartDiseaseDiseaseTypesDTOList	= new ArrayCollection();							
			}						
			if(model.hypertensionDiseaseTypesDTOList ==  null)
			{
				model.hypertensionDiseaseTypesDTOList	= new ArrayCollection();							
			}						
			if(model.otherDiseaseTypesDTOList ==  null)
			{
				model.otherDiseaseTypesDTOList = new ArrayCollection();							
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadFamilyDiseaseStaticDataCommand.";
			//	Alert.show("Fault occured in LoadFamilyDiseaseStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadFamilyDiseaseStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}