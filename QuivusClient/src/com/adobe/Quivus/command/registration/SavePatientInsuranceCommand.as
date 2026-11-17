package com.adobe.Quivus.command.registration
{
	import com.adobe.Quivus.delegate.registration.SavePatientInsuranceDelegate;
	import com.adobe.Quivus.events.registration.SavePatientInsuranceEvent;
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
	
	
	public class SavePatientInsuranceCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		public var purpose		: String;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : SavePatientInsuranceDelegate = new SavePatientInsuranceDelegate( this );
				var LE:SavePatientInsuranceEvent = cgEvent as SavePatientInsuranceEvent;
				this.functionName = LE.functionName;
				this.purpose	  = LE.purpose;
				delegate.SavePatientInsurance(LE.patientId,model.loggedInUserDTO.UserId,LE.patientInsuranceDTOList,model.sessionDTO);
			}
			
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var serviceResponse:ServiceResponse = re.result as ServiceResponse;
				
				//if(serviceResponse!=null && serviceResponse.ResponseStatus){
					 
					
					/*var rpEvent : SaveAddressBookEvent = new SaveAddressBookEvent(model.patientId,model.addressBookDTO);
					CairngormEventDispatcher.getInstance().dispatchEvent( rpEvent );*/
				/*}
				else
				{
					Alert.show(serviceResponse.ResponseMessage, "Error",4, FlexGlobals.topLevelApplication.mainContainer);
				}*/
				if(serviceResponse.ResponseMessage!=null && serviceResponse.ResponseMessage.length>0)
					model.registrationErrorMsg +=serviceResponse.ResponseMessage+"\n";
				
				if(serviceResponse==null)
				{
					Alert.show("SavePatientInsurance"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
					
				}
				model.regEventCount= model.regEventCount-1;
				if(this.purpose==Constants.REGISTRATION_PURPOSE)
				{
					
					if(model.regEventCount == 0)
					{
						if(model.registrationErrorMsg==null || model.registrationErrorMsg.length==0)
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
				}else if(this.purpose==Constants.UPDATE_PURPOSE)
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
				model.errorStatus = "Fault occured in SavePatientInsuranceCommand.";
			//	Alert.show("Fault occured in SavePatientInsuranceCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in SavePatientInsuranceCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}