package com.adobe.Quivus.command.staticData.hpi
{
	
	
	import com.adobe.Quivus.delegate.staticData.hpi.LoadHPIStaticDataDelegate;
	import com.adobe.Quivus.events.staticData.hpi.LoadHPIStaticDataEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
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

	
	public class LoadHPIStaticDataCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		private var sectionId : int;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadHPIStaticDataDelegate = new  LoadHPIStaticDataDelegate(this);
				 
				 var LE:LoadHPIStaticDataEvent = cgEvent as LoadHPIStaticDataEvent;
				 this.sectionId = LE.sectionId;
				 delegate.LoadHPIStaticData(LE.sectionId,
					 						model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
										model.sessionDTO,
										LE.searchString);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var hpiDetailAutoCompleteResponse:HPIDetailAutoCompleteResponse = re.result as HPIDetailAutoCompleteResponse;
				
				if(hpiDetailAutoCompleteResponse!=null)
				{
					if(hpiDetailAutoCompleteResponse.ResponseStatus)
					{
						if(model.hpiCallNumber ==1)
						{
							
							model.contextList = hpiDetailAutoCompleteResponse.AutoCompleteList;
							
							model.hpiCallNumber = 2;
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.DURATION_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
							
						}
						else if(model.hpiCallNumber ==2)
						{
							model.duration = hpiDetailAutoCompleteResponse.AutoCompleteList;
							
							model.hpiCallNumber = 3;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.EXACERBATING_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber ==3)
						{
							model.exacerbating = hpiDetailAutoCompleteResponse.AutoCompleteList;
							
							model.hpiCallNumber = 4;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.LOCATION_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}	
						else if(model.hpiCallNumber ==4)
						{
							model.location = hpiDetailAutoCompleteResponse.AutoCompleteList;
							
							model.hpiCallNumber = 5;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.MODIFYINGFACTORS_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 5)
						{
							model.modifyingFactors = hpiDetailAutoCompleteResponse.AutoCompleteList;				
							
							model.hpiCallNumber = 6;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.PROGRESSION_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 6)
						{
							model.progression = hpiDetailAutoCompleteResponse.AutoCompleteList;				
							
							model.hpiCallNumber = 7;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.QUALITY_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 7)
						{
							model.quality = hpiDetailAutoCompleteResponse.AutoCompleteList;				
							
							model.hpiCallNumber = 8;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.RADIATION_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 8)
						{
							model.radiation = hpiDetailAutoCompleteResponse.AutoCompleteList;				
							
							model.hpiCallNumber = 9;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.SEVERITY_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 9)
						{
							model.severity = hpiDetailAutoCompleteResponse.AutoCompleteList;				
							
							model.hpiCallNumber = 10;
							
							var sectionId:int = QSUtilityFunctions.getHPIDetailTypeIdByName(Constants.SYMPTOM_MODULE_NAME);
							var ldsdEvent : LoadHPIStaticDataEvent = new LoadHPIStaticDataEvent(sectionId,Constants.EMPTY_STRING);
							CairngormEventDispatcher.getInstance().dispatchEvent( ldsdEvent );
						}
						else if(model.hpiCallNumber == 10)
						{
							model.symptom = hpiDetailAutoCompleteResponse.AutoCompleteList;								
							
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(hpiDetailAutoCompleteResponse.ResponseCode);
						if(valid)
							Alert.show("LoadHPIStaticData"+"\n"+hpiDetailAutoCompleteResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadHPIStaticData"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadHPIStaticDataCommand.";
			//	Alert.show("Fault occured in LoadHPIStaticDataCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadHPIStaticDataCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}