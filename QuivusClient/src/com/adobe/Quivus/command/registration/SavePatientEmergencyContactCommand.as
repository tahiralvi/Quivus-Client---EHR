package com.adobe.Quivus.command.registration
{
	import com.adobe.Quivus.delegate.registration.SavePatientEmergencyContactDelegate;
	import com.adobe.Quivus.events.registration.SavePatientEmergencyContactEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.DTOInitializationUtility;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class SavePatientEmergencyContactCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		public var purpose		: String;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SavePatientEmergencyContactDelegate = new SavePatientEmergencyContactDelegate( this );
				var LE:SavePatientEmergencyContactEvent = cgEvent as SavePatientEmergencyContactEvent;
				this.functionName = LE.functionName;
				this.purpose	  = LE.purpose;
				delegate.SavePatientEmergencyContact(LE.patientId,model.loggedInUserDTO.UserId,LE.emergencyContatcList,model.sessionDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{	
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var managePatientEmergencResponse:PatientEmergencyResponse = re.result as PatientEmergencyResponse;
				
				//if(managePatientEmergencResponse!=null && managePatientEmergencResponse.ResponseStatus){
					 
					
					/*var rpEvent : SavePatientGuarantorEvent = new SavePatientGuarantorEvent(model.patientId,model.patientGuarantorDTO);
					CairngormEventDispatcher.getInstance().dispatchEvent( rpEvent );*/
				/*}
				else
				{
					Alert.show(managePatientEmergencResponse.ResponseMessage, "Error",4, FlexGlobals.topLevelApplication.mainContainer);
				}*/
				
				if(managePatientEmergencResponse==null)
				{
					Alert.show("SavePatientEmergencyContact"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					
				}
				
				if(managePatientEmergencResponse.ResponseMessage!=null && managePatientEmergencResponse.ResponseMessage.length>0)
					model.registrationErrorMsg +=managePatientEmergencResponse.ResponseMessage+"\n";
				
				model.regEventCount= model.regEventCount-1;
				if(this.purpose==Constants.REGISTRATION_PURPOSE)
				{
					
					if(model.regEventCount == 0)
					{
						if(model.registrationErrorMsg==null || model.registrationErrorMsg.length==0 )
						{
							Alert.show(Messages.REGISTRATION_SUCCESSFULL, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
							if(this.functionName!=null)
							{
								functionName();
							}
							DTOInitializationUtility.InitializeRegistrationDTOs();
						}
						else
						{
							Alert.show(model.registrationErrorMsg, "Registration",4, FlexGlobals.topLevelApplication.mainContainer);
						}
					}
					
				}
				else if(this.purpose==Constants.UPDATE_PURPOSE)
				{
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
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in SavePatientEmergencyContactCommand.";
			//	Alert.show("Fault occured in SavePatientEmergencyContactCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SavePatientEmergencyContactCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}