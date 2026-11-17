package com.adobe.Quivus.command.staticData.comprehensiveHistory
{
	
	
	import com.adobe.Quivus.delegate.staticData.comprehensiveHistory.LoadFamilyHistoryTypesDelegate;
	import com.adobe.Quivus.delegate.staticData.comprehensiveHistory.LoadGeneralHistoryTypesDelegate;
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
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadFamilyHistoryTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadFamilyHistoryTypesDelegate = new  LoadFamilyHistoryTypesDelegate(this);
				 
				 if(perUtil.isCompHistoryLocalDBAvaliable())
				 { 
					 perUtil.loadSpecifiedCompHistoryData(Constants.CH_SECTION_FAMILY);
					 
					 perUtil.loadSpecifiedCompHistoryData(Constants.FAMILY_CANCER_MODULE_NAME);
					 perUtil.loadSpecifiedCompHistoryData(Constants.FAMILY_DIABETES_MODULE_NAME);
					 perUtil.loadSpecifiedCompHistoryData(Constants.FAMILY_HEART_DISEASE_MODULE_NAME);
					 perUtil.loadSpecifiedCompHistoryData(Constants.FAMILY_HYPERTENSION_MODULE_NAME);
					 perUtil.loadSpecifiedCompHistoryData(Constants.FAMILY_OTHER_MODULE_NAME);
				 }
				 else
				 {
					 delegate.LoadFamilyHistoryTypes(model.sessionDTO);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var familyHistoryTypeResponse:FamilyHistoryTypeResponse = re.result as FamilyHistoryTypeResponse;
				
				if(familyHistoryTypeResponse!=null)
				{
					if(familyHistoryTypeResponse.ResponseStatus)
					{
						model.allFamilyHistoryTypeDTOList = familyHistoryTypeResponse.FamilyHistoryList;
						
						// for loading the diseases of  family history
						if(model.otherDiseaseTypesDTOList ==null || model.otherDiseaseTypesDTOList.length==0)
						{
							model.diseaseCallNumber= 1;
							var cancerDTO:FamilyHistoryTypeDTO = QSUtilityFunctions.getFamilyHistoryTypeDTOByName(Constants.FAMILY_CANCER_MODULE_NAME);
							var ldsdEvent : LoadFamilyDiseaseStaticDataEvent = new LoadFamilyDiseaseStaticDataEvent(cancerDTO);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						
						perUtil.initializeSpecifiedCompHistoryDB(Constants.CH_SECTION_FAMILY);
						
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(familyHistoryTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadFamilyHistoryTypes"+"\n"+familyHistoryTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadFamilyHistoryTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadFamilyHistoryTypesCommand.";
			//	Alert.show("Fault occured in LoadFamilyHistoryTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadFamilyHistoryTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}