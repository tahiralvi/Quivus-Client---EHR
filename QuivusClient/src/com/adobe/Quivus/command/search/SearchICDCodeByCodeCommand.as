package com.adobe.Quivus.command.search
{
	import com.adobe.Quivus.delegate.search.SearchICDCodeByCodeDelegate;
	import com.adobe.Quivus.events.search.SearchICDCodeByCodeEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;

	
	public class SearchICDCodeByCodeCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SearchICDCodeByCodeDelegate = new SearchICDCodeByCodeDelegate( this );
				
				var LE:SearchICDCodeByCodeEvent = cgEvent as SearchICDCodeByCodeEvent;
				
				if(LE.icdCode!=null && LE.icdCode.length>0){
					delegate.SearchICDCodeByCode(LE.icdCode,model.sessionDTO);
				}
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var icdCodeResponse:ICDCodeResponse = re.result as ICDCodeResponse;
				if(icdCodeResponse!=null)
				{
					if(icdCodeResponse.ResponseStatus){
						
						if(icdCodeResponse.ResponseData!=null){
							model.icdCodeList = icdCodeResponse.ResponseData;
						} 
					}
				}
				else
				{
					Alert.show("SearchICDCodeByCode"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SearchICDCodeByCodeCommand.";
				//Alert.show("Fault occured in SearchICDCodeByCodeCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SearchICDCodeByCodeCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}