package com.adobe.Quivus.command.registration
{
	import com.adobe.Quivus.delegate.registration.RegisterUserProfileDelegate;
	import com.adobe.Quivus.events.registration.RegisterPatientProfileAndLanguageEvent;
	import com.adobe.Quivus.events.registration.RegisterUserProfileEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.event.SavePatientGaxenIdEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class RegisterUserProfileCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		public var purpose		: String;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : RegisterUserProfileDelegate = new RegisterUserProfileDelegate( this );
				var LE:RegisterUserProfileEvent = cgEvent as RegisterUserProfileEvent;
				
				this.functionName = LE.functionName;
				this.purpose	  = LE.purpose;
				
				
				delegate.RegisterUserProfile(model.basicUserDTO,model.loggedInUserDTO.UserId,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var baseUserRegistrationResponse:BaseUserRegistrationResponse = re.result as BaseUserRegistrationResponse;
				
				if(baseUserRegistrationResponse!=null && baseUserRegistrationResponse.ResponseStatus )
				{
					if(this.purpose == Constants.REGISTRATION_PURPOSE)
					{
						model.patientUserId = baseUserRegistrationResponse.UserId;
						// Tahir Alvi -  save patient GaxenID if allergy is saved during registration
						if(model.newRegGaxenID != null)
						{
							if(model.newRegGaxenID && model.newRegGaxenID != "0" && !model.gaxenIDSaved)
							{
								var gEvent : SavePatientGaxenIdEvent = new SavePatientGaxenIdEvent(model.patientUserId.toString(), model.newRegGaxenID , callback);					
								CairngormEventDispatcher.getInstance().dispatchEvent( gEvent );
							}
						}
						
						var rpEvent : RegisterPatientProfileAndLanguageEvent = new RegisterPatientProfileAndLanguageEvent(Constants.REGISTRATION_PURPOSE,model.patientDTO,model.patientLanguageDTOList,this.purpose,this.functionName);
						CairngormEventDispatcher.getInstance().dispatchEvent( rpEvent );
					}
					else if(this.purpose==Constants.UPDATE_PURPOSE)
					{
						if(baseUserRegistrationResponse.ResponseMessage!=null && baseUserRegistrationResponse.ResponseMessage.length>0)
							model.registrationErrorMsg +=baseUserRegistrationResponse.ResponseMessage+"\n";
						
						model.regEventCount= model.regEventCount-1;
						if(model.regEventCount == 0)
						{
							if(model.registrationErrorMsg==null || model.registrationErrorMsg.length==0 )
							{
								Alert.show(Messages.UPDATE_PROFILE_SUCCESSFULL, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
								if(this.functionName!=null)
								{
									functionName();
								}
								QuivusCombineEventDispatcher.afterPatientProfileUpdation(model.loadedPatientId);
								//DTOInitializationUtility.InitializeRegistrationDTOs();
							}
							else
							{
								Alert.show(model.registrationErrorMsg, "Updation",4, FlexGlobals.topLevelApplication.mainContainer);
							}
						}
					}
				}
				else
				{
					var valid:Boolean = QSUtilityFunctions.checkSession(baseUserRegistrationResponse.ResponseCode);
					if(valid)
						Alert.show("RegisterUserProfile"+"\n"+baseUserRegistrationResponse.ResponseMessage, "Error",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		//--Tahir Alvi - return result of SavePatientGaxenIdEvent
		private function callback(val:Boolean):void
		{
			model.isAtRegGaxenID = true;
			if(model.isAtRegGaxenID)
			{
				model.gaxenIDSaved 			= false;
				model.newRegGaxenID 		= '';
				model.QIAllergyDTOList.removeAll();
			}
		} 
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
			model.errorStatus = "Fault occured in RegisterUserProfileCommand.";
			//	Alert.show("Fault occured in RegisterUserProfileCommand.\n"+rpcEvent.toString());
			//}
			/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
			cAlert.Show(rpcEvent.toString(),"Fault occured in RegisterUserProfileCommand ","",model.loggedInUserDTO.UserId);
			PopUpManager.centerPopUp(cAlert);*/
			
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
			QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}
