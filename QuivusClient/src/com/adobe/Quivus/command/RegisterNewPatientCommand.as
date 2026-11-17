package com.adobe.Quivus.command
{
	import com.adobe.Quivus.delegate.RegisterNewPatientDelegate;
	import com.adobe.Quivus.events.RegisterNewPatientEvent;
	import com.adobe.Quivus.model.AppModelLocator;
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

	[Deprecated("this registers a patient in one call, but currently, registration is done in multiple-calls")]
	public class RegisterNewPatientCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : RegisterNewPatientDelegate = new RegisterNewPatientDelegate( this );
				var LE:RegisterNewPatientEvent = cgEvent as RegisterNewPatientEvent;
				var regDTO:RegistrationDTO= LE.registrationDTO;
				
				delegate.registerNewPatient(regDTO);
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var registrationResDTO:UserRegistrationResponse = re.result as UserRegistrationResponse;
				
				
				//if(registrationResDTO.ResponseStatus)
				//{
					Alert.show("Patient Registered Successfully.");
				//}
			}
		}
		
		
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in LoginCommand.";
				//Alert.show("Fault occured in LoginCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in LoginCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}