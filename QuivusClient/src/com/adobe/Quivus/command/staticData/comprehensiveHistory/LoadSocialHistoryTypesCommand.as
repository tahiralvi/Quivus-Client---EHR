package com.adobe.Quivus.command.staticData.comprehensiveHistory
{
	
	
	import com.adobe.Quivus.delegate.staticData.comprehensiveHistory.LoadSocialHistoryTypesDelegate;
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

	
	public class LoadSocialHistoryTypesCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		private var perUtil:PersistanceUtility = new PersistanceUtility();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadSocialHistoryTypesDelegate = new  LoadSocialHistoryTypesDelegate(this);
				 
				 if(perUtil.isCompHistoryLocalDBAvaliable())
				 { 
					 perUtil.loadSpecifiedCompHistoryData(Constants.CH_SECTION_SOCIAL);
				 }
				 else
				 {
					 delegate.LoadSocialHistoryTypes(model.sessionDTO);
				 }
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var socialHistoryAddictionTypeResponse:SocialHistoryAddictionTypeResponse = re.result as SocialHistoryAddictionTypeResponse;
				
				if(socialHistoryAddictionTypeResponse!=null)
				{
					if(socialHistoryAddictionTypeResponse.ResponseStatus)
					{
						model.allSocialHistoryAddictionTypeDTOList = socialHistoryAddictionTypeResponse.SocialHistoryAddictionList;
						
						perUtil.initializeSpecifiedCompHistoryDB(Constants.CH_SECTION_SOCIAL);
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(socialHistoryAddictionTypeResponse.ResponseCode);
						if(valid)
							Alert.show("LoadSocialHistoryTypes"+"\n"+socialHistoryAddictionTypeResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadSocialHistoryTypes"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadSocialHistoryTypesCommand.";
			//	Alert.show("Fault occured in LoadSocialHistoryTypesCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadSocialHistoryTypesCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}