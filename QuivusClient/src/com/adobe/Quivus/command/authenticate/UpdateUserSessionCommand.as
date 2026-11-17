package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.UpdateUserSessionDelegate;
	import com.adobe.Quivus.events.authenticate.UpdateUserSessionEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.UserSessionDTO;
	
	public class UpdateUserSessionCommand implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			if(model.UserLoggedIn)
			{
				var delegate : UpdateUserSessionDelegate = new UpdateUserSessionDelegate( this );
				
				var LE:UpdateUserSessionEvent = cgEvent as UpdateUserSessionEvent;
				
				delegate.UpdateUserSession(LE.sessionDTO);
			}
		}
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{	
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var res:UserSessionDTO = re.result as UserSessionDTO;
				
				if(model.KickOutPreviousSession)
				{
					QuivusCombineEventDispatcher.dispatchSuccessFullLoginEvent();
				}
				else
				{
					QSUtilityFunctions.signOutDueToAnotherUserLoggedIn();
				}
				/*if(res!=null)
				{
					model.sessionDTO = res;
					
					if(model.sessionDTO.KickOutPreviousSession)
					{
						QuivusCombineEventDispatcher.dispatchSuccessFullLoginEvent();
					}
					else
					{
						UtilityFunctions.signOutDueToAnotherUserLoggedIn();
					}
						
				}
				else
				{
					Alert.show("UpdateUserSession"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}*/
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in UpdateUserSessionCommand.";
			//	Alert.show("Fault occured in UpdateUserSessionCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in UpdateUserSessionCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/ 
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in UpdateUserSessionCommand", rpcEvent.toString(), userId); 
			
		}
		
	}
	
}