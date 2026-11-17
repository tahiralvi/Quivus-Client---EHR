package com.adobe.Quivus.command.staticData.visit
{
	import com.adobe.Quivus.delegate.staticData.visit.LoadVisitEncounterTypesDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.sql.PersistanceUtility;
	import com.adobe.Quivus.vo.patientProfileCustomization.MainCategoryVO;
	import com.adobe.Quivus.vo.patientProfileCustomization.SubCategoryVO;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
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

	
	public class LoadVisitEncounterTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadVisitEncounterTypesDelegate = new LoadVisitEncounterTypesDelegate( this );
				
				if(perUtil.isQuickInputLocalDBAvaliable())
				{
					// model.labNatureTypeDTOList = new ArrayCollection();
					
					perUtil.loadSpecifiedQuickInputData(Constants.ENCOUNTER_TYPE_QUICKINPUT_STATIC_DATA);
				}
				else
				{
					delegate.LoadVisitEncounterTypes(model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var encounterTypeResponse :EncounterTypeResponse  = re.result as EncounterTypeResponse ;
				
				if(encounterTypeResponse!=null)
				{
					if(encounterTypeResponse.ResponseStatus)
					{
						model.encounterTypeDTOList = encounterTypeResponse.EncounterTypeList;
						
						perUtil.initializeSpecifiedQuickInputDB(Constants.ENCOUNTER_TYPE_QUICKINPUT_STATIC_DATA);
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(encounterTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadVisitEncounterTypes"+"\n"+encounterTypeResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadVisitEncounterTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
			
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadVisitEncounterTypesCommand.";
			//	Alert.show("Fault occured in LoadVisitEncounterTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadVisitEncounterTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}