package com.adobe.Quivus.command.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.LoadPatientFamilyHistoryByVisitIdDelegate;
	import com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory.LoadPatientSocialHistoryByVisitIdDelegate;
	import com.adobe.Quivus.events.viewBackground.comprehensiveHistory.LoadPatientSocialHistoryByVisitIdEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
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

	
	public class LoadPatientSocialHistoryByVisitIdCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadPatientSocialHistoryByVisitIdDelegate = new LoadPatientSocialHistoryByVisitIdDelegate( this );
				
				var LE:LoadPatientSocialHistoryByVisitIdEvent = cgEvent as LoadPatientSocialHistoryByVisitIdEvent;
				
				delegate.LoadPatientSocialHistoryByVisitId(LE.visitId,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var resp:SocialHistoryResponse  = re.result as SocialHistoryResponse ;
				if(resp!=null)
				{
					if(resp.ResponseStatus)
					{
						model.socialHistoryDTOListByVisit  = resp.SocialHistoryList;
						
					}
					else
					{
						model.errorStatus = resp.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(resp.ResponseCode);
						if(valid)
							Alert.show("LoadPatientSocialHistoryByVisitId"+"\n"+resp.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadPatientSocialHistoryByVisitId"+"\n"+Messages.SERVICE_DIDNOT_RESPOND+"",  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadPatientSocialHistoryByVisitIdCommand.";
			//	Alert.show("Fault occured in LoadPatientSocialHistoryByVisitIdCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadPatientSocialHistoryByVisitIdCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}