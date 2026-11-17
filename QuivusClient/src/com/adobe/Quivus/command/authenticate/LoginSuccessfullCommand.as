package com.adobe.Quivus.command.authenticate
{
	import com.adobe.Quivus.delegate.authenticate.LoginSuccessfullDelegate;
	import com.adobe.Quivus.events.authenticate.UpdateUserSessionEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.common.util.exceptionAlert.QSExceptionAlert;
	import com.gazuntite.dataBridge.controller.LiveServicesController;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.UserSessionDTO;
	
	public class LoginSuccessfullCommand implements com.adobe.cairngorm.commands.Command, IResponder 
	{
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			if(model.UserLoggedIn)
			{
				var delegate : LoginSuccessfullDelegate = new LoginSuccessfullDelegate( this );
				
				/*LiveServicesController.updateDMModel( model.loggedInUserDTO.UserId,
				model.userSelectedRoleDTO.UserTypeProfileID,
				model.userSelectedRoleDTO.UserTypeRole.UserTypeId, 
				model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq,
				model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchName,
				model.userSelectedStationDTO.StationName,
				model.userSelectedStationDTO.StationID);*/
				
				QuivusCombineEventDispatcher.UpdateModel();
				
				//delegate.SendLoginDataToLog(model.loggedInUserDTO.UserId,
				//						model.userSelectedRoleDTO.UserTypeRole.UserTypeId, 
				//					    model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq);
			}
		}
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{	
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var res:UserSessionDTO = re.result as UserSessionDTO;
				
				if(res!=null)
				{
					model.sessionDTO = res;
					
					if(model.sessionDTO.IsAlreadyLoggedIn)
					{
						Alert.show("You are already logged in from IP<"+model.sessionDTO.ClientIPAdress+">. Are you sure you want to logout and login here?", 
							"Info",
							Alert.YES | Alert.NO, FlexGlobals.topLevelApplication.mainContainer, 
							function handleAlert(event:CloseEvent):void
							{
								if (event.detail == Alert.YES)
								{
									model.sessionDTO.KickOutPreviousSession = true;		
									model.KickOutPreviousSession			= true;
									model.sessionDTO.UserSessionStatusID = 1;
									QuivusCombineEventDispatcher.dispatchSuccessFullLoginEvent();
								}
								else if( event.detail == Alert.NO)
								{
									model.sessionDTO.KickOutPreviousSession = false;	
									model.KickOutPreviousSession			= false;
									QSUtilityFunctions.signOutDueToAnotherUserLoggedIn();
									//logoout...
								}
								
								var uusEvent : UpdateUserSessionEvent = new UpdateUserSessionEvent(model.sessionDTO);									
								CairngormEventDispatcher.getInstance().dispatchEvent( uusEvent );
							});
						
					}
					else
					{
						QuivusCombineEventDispatcher.dispatchSuccessFullLoginEvent();
					}
					
				}
				else
				{
					Alert.show("LoginSuccessfullCm"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in LoginSuccessfullCommand.";
			//Alert.show("Fault occured in LoginSuccessfullCommand.\n"+rpcEvent.toString());*/
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in LoginSuccessfullCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert); */
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( "Fault occured in LoginSuccessfullCommand", rpcEvent.toString(), userId); 
			
		}
		
	}
	
}