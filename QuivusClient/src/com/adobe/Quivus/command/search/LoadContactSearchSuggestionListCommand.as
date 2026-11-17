package com.adobe.Quivus.command.search
{
	import com.adobe.Quivus.delegate.search.LoadContactSearchSuggestionListDelegate;
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

	
	public class LoadContactSearchSuggestionListCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : LoadContactSearchSuggestionListDelegate = new LoadContactSearchSuggestionListDelegate( this );
				
				var userId:int = model.loggedInUserDTO.UserId;
				var clinicBranchId:int = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq;
				if(userId>0 && clinicBranchId>0){
					delegate.LoadContactSearchSuggestionList(userId,clinicBranchId,model.sessionDTO);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var csDTO:ContactSearchResponse = re.result as ContactSearchResponse;
				if(csDTO!=null)
				{
					if(csDTO.ResponseStatus)
					{
						if(csDTO.ResponseData!=null)
						{
							model.contactSearchSuggestionList = csDTO.ResponseData;
						}
						else
						{
							Alert.show(Messages.NO_DATA_RETURNED_FROM_SERVICE, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					else
					{
						model.errorStatus = csDTO.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(csDTO.ResponseCode);
						if(valid)
							Alert.show(csDTO.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
					Alert.show("LoadContactSearchSuggestionList"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoadContactSearchSuggestionListCommand.";
				//Alert.show("Fault occured in LoadContactSearchSuggestionListCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoadContactSearchSuggestionListCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}