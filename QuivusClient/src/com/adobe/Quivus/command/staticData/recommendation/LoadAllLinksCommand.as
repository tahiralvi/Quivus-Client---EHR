package com.adobe.Quivus.command.staticData.recommendation
{
	
	
	import com.adobe.Quivus.delegate.staticData.recommendation.LoadAllLinksDelegate;
	import com.adobe.Quivus.events.staticData.recommendation.LoadAllLinksEvent;
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

	
	public class LoadAllLinksCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				 var delegate:LoadAllLinksDelegate = new  LoadAllLinksDelegate(this);
				 
				 var LE:LoadAllLinksEvent = cgEvent as LoadAllLinksEvent;
				 
				 delegate.LoadAllLinks(model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
				 					LE.searchString,
				 					model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var linksResponse:LinksAutoCompleteResponse = re.result as LinksAutoCompleteResponse;
				
				if(linksResponse!=null)
				{
					if(linksResponse.ResponseStatus)
					{
						if(linksResponse.LinksList!=null){
	
							model.linksList = linksResponse.LinksList;
						}
						else
						{
							Alert.show("LoadAllLinks"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE.toString(),  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						var valid:Boolean = QSUtilityFunctions.checkSession(linksResponse.ResponseCode);
						if(valid)
							Alert.show("LoadAllLinks"+"\n"+linksResponse.ResponseMessage,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadAllLinks"+"\n"+Messages.SERVICE_DIDNOT_RESPOND ,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadAllLinksCommand.";
			//	Alert.show("Fault occured in LoadAllLinksCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadAllLinksCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}