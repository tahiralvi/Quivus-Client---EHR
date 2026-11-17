package com.adobe.Quivus.command.quickLink
{
	import com.adobe.Quivus.delegate.quickLink.LoadUserQuickLinksDelegate;
	import com.adobe.Quivus.events.quickLink.LoadUserQuickLinksEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class LoadUserQuickLinksCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadUserQuickLinksDelegate = new LoadUserQuickLinksDelegate( this );
				
				var userId:int = model.loggedInUserDTO.UserId;
				var clinicBranchId:int = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				if(userId>0 && clinicBranchId>0){
					delegate.LoadUserQuickLinks(userId,clinicBranchId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var quickLinksResponceDTO:QuickLinkResponse = re.result as QuickLinkResponse;
				
				if(quickLinksResponceDTO!=null)
				{
					if(quickLinksResponceDTO.ResponseStatus)
					{
						if(quickLinksResponceDTO.ResponseData!=null){
							if(model.allQuickLinksDTOList!=null){
								model.allQuickLinksDTOList.removeAll();
							}
							model.userQuickLinksDTOList = quickLinksResponceDTO.ResponseData;
							model.quicklinkEnabled =true;
							//T
							LoadUserQuickLinksEvent.isAlreadyLoaded = true;
						}
						else
						{
							Alert.show("LoadUserQuickLinks"+"\n"+Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						model.errorStatus = quickLinksResponceDTO.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(quickLinksResponceDTO.ResponseCode);
						if(valid)
							Alert.show("LoadUserQuickLinks"+"\n"+quickLinksResponceDTO.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadUserQuickLinks"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadUserQuickLinksCommand.";
			//	Alert.show("Fault occured in LoadUserQuickLinksCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadUserQuickLinksCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}