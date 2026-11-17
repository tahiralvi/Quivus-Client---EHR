package com.adobe.Quivus.command.staticData.recommendation
{
	
	
	import com.adobe.Quivus.delegate.staticData.recommendation.LoadAllPlanTypesDelegate;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.sql.PersistanceUtility;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadAllPlanTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadAllPlanTypesDelegate = new  LoadAllPlanTypesDelegate(this);
				 
				 delegate.LoadAllPlanTypes(model.sessionDTO);
				
				/* if(perUtil.isQuickInputLocalDBAvaliable())
				 {
					 // model.labNatureTypeDTOList = new ArrayCollection();
					 
					 perUtil.loadSpecifiedQuickInputData(Constants.PLAN_TYPE_QUICKINPUT_STATIC_DATA);
				 }
				 else
				 {
					 delegate.LoadAllPlanTypes(model.sessionDTO);
				 }*/
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var planTypeResponse:PlanTypeResponse = re.result as PlanTypeResponse;
				
				if(planTypeResponse!=null)
				{
					if(planTypeResponse.ResponseStatus)
					{
						if(planTypeResponse.PlanTypeList!=null){
	
							model.planTypesList = planTypeResponse.PlanTypeList;
							
							perUtil.initializeSpecifiedQuickInputDB(Constants.PLAN_TYPE_QUICKINPUT_STATIC_DATA);
						}
						else
						{
							Alert.show("LoadPlanTypes"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(planTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadPlanTypes"+"\n"+planTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPlanTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPlanTypesCommand.";
			//	Alert.show("Fault occured in LoadPlanTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPlanTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}