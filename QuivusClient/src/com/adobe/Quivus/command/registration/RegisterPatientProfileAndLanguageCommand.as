package com.adobe.Quivus.command.registration
{
	import com.adobe.Quivus.delegate.registration.RegisterPatientProfileAndLanguageDelegate;
	import com.adobe.Quivus.events.registration.RegisterPatientProfileAndLanguageEvent;
	import com.adobe.Quivus.events.registration.SaveAddressBookEvent;
	import com.adobe.Quivus.events.registration.SavePatientEmergencyContactEvent;
	import com.adobe.Quivus.events.registration.SavePatientGuarantorEvent;
	import com.adobe.Quivus.events.registration.SavePatientHealthInfoEvent;
	import com.adobe.Quivus.events.registration.SavePatientImageEvent;
	import com.adobe.Quivus.events.registration.SavePatientInsuranceEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.utils.Constants;
	import com.adobe.Quivus.utils.Messages;
	import com.adobe.Quivus.utils.QSUtilityFunctions;
	import com.adobe.Quivus.utils.QuivusCombineEventDispatcher;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.*;
	
	
	public class RegisterPatientProfileAndLanguageCommand  implements com.adobe.cairngorm.commands.Command, IResponder {
		
		private var model : AppModelLocator = AppModelLocator.getInstance();
		public var functionName : Function;
		public var purpose		: String;
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.UserLoggedIn)
			{
				var delegate : RegisterPatientProfileAndLanguageDelegate = new RegisterPatientProfileAndLanguageDelegate( this );
				var LE:RegisterPatientProfileAndLanguageEvent = cgEvent as RegisterPatientProfileAndLanguageEvent;
				this.functionName = LE.functionName;
				this.purpose	  = LE.purpose;
				
				removeEmptyLanguages(LE.patientLanguageDTOList);
				
				delegate.RegisterPatientProfileAndLanguages(model.patientUserId,LE.patientDTO,LE.patientLanguageDTOList,model.loggedInUserDTO.UserId,model.sessionDTO);
			}
		}		
		
		public function result( rpcEvent : Object ) : void {
			if(model.UserLoggedIn)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var patientSaveResponse:PatientSaveResponse = re.result as PatientSaveResponse;
				if(patientSaveResponse!=null && patientSaveResponse.ResponseStatus )
				{
					if( this.purpose==Constants.REGISTRATION_PURPOSE)
					{
						model.patientId = patientSaveResponse.PatientId;
						
						if(model.patientEmergencyContactDTOList!=null && model.patientEmergencyContactDTOList.length>0)
						{
							var ecEvent : SavePatientEmergencyContactEvent = new SavePatientEmergencyContactEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.patientEmergencyContactDTOList,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( ecEvent );
							model.regEventCount= model.regEventCount+1;
						}
						
						/*if(model.patientGuarantorDTO!=null && model.patientGuarantorDTO.GurantorFirstName!=null && model.patientGuarantorDTO.GurantorFirstName.length>0)
						{
							var gEvent : SavePatientGuarantorEvent = new SavePatientGuarantorEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.patientGuarantorDTO,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( gEvent );
							model.regEventCount= model.regEventCount+1;
						}*/
						//Start -- Tahir Alvi 
						if(model.patientGuarantorDTOList!=null && model.patientGuarantorDTOList.length >0)
						{
							var gEvent : SavePatientGuarantorEvent = new SavePatientGuarantorEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.patientGuarantorDTOList,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( gEvent );
							model.regEventCount= model.regEventCount+1;
						}
						//End -- Tahir Alvi 
						
						if(model.patientInsuranceDTOList!=null && model.patientInsuranceDTOList.length>0)
						{
							var piEvent : SavePatientInsuranceEvent = new SavePatientInsuranceEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.patientInsuranceDTOList,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( piEvent );
							model.regEventCount= model.regEventCount+1;
						}				
						
						var abEvent : SaveAddressBookEvent = new SaveAddressBookEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.addressBookDTO,this.functionName);
						CairngormEventDispatcher.getInstance().dispatchEvent( abEvent );
						model.regEventCount= model.regEventCount+1;
						
						
						if(model.healthHX!=null)
						{
							var hEvent : SavePatientHealthInfoEvent = new SavePatientHealthInfoEvent(Constants.REGISTRATION_PURPOSE,model.patientId,model.healthHX,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( hEvent );
							model.regEventCount= model.regEventCount+1;
						}
						
						if(model.patientRegImageDTO!=null && model.patientRegImageDTO.ImageData!=null && model.patientRegImageDTO.ImageData.length>0)
						{
							model.patientRegImageDTO.UserId=model.patientUserId;
							model.patientRegImageDTO.UserTypeID = Constants.PATIENT_USER_TYPE_ID;
							model.patientRegImageDTO.CreatedAt = new Date();
							model.patientRegImageDTO.CreatedBy = model.loggedInUserDTO.UserId;
							model.patientRegImageDTO.ImageTypeId = model.profileImageTypeDTO.ImageTypeId;
							
							var pimEvent : SavePatientImageEvent = new SavePatientImageEvent(Constants.REGISTRATION_PURPOSE,this.functionName);
							CairngormEventDispatcher.getInstance().dispatchEvent( pimEvent );
							model.regEventCount= model.regEventCount+1;
						}
					}
					else if(this.purpose==Constants.UPDATE_PURPOSE)
					{
						if(patientSaveResponse.ResponseMessage!=null && patientSaveResponse.ResponseMessage.length>0)
							model.registrationErrorMsg +=patientSaveResponse.ResponseMessage+"\n";
						
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
				else if(patientSaveResponse==null)
				{
					Alert.show("RegisterPatientProfileAndLanguage"+"\n"+Messages.SERVICE_DIDNOT_RESPOND,  Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
				else
				{
					model.errorStatus = patientSaveResponse.ResponseMessage ;
					var valid:Boolean = QSUtilityFunctions.checkSession(patientSaveResponse.ResponseCode);
					if(valid)
						Alert.show("RegisterPatientProfileAndLanguage"+"\n"+patientSaveResponse.ResponseMessage, Messages.INFO,4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		private function removeEmptyLanguages(patientLanguageDTOList:ArrayCollection) : void
		{
			var index:int;
			
			for(index = 0; index<patientLanguageDTOList.length && index >=0;index++)
			{
				var pl:PatientLanguageDTO;
				
				pl = patientLanguageDTOList.getItemAt(index) as PatientLanguageDTO;
				
				if(pl.LanguageID == 0)
				{
					patientLanguageDTOList.removeItemAt(index);
					index--;
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void {
			//if(model.isUserManagerServiceOnline){
				model.errorStatus = "Fault occured in RegisterPatientProfileAndLanguageCommand.";
				//Alert.show("Fault occured in RegisterPatientProfileAndLanguageCommand.\n"+rpcEvent.toString());
			//}
				/*var  cAlert:QSExceptionAlert = PopUpManager.createPopUp(FlexGlobals.topLevelApplication.mainContainer,QSExceptionAlert, true) as QSExceptionAlert;
				cAlert.Show(rpcEvent.toString(),"Fault occured in RegisterPatientProfileAndLanguageCommand ","",model.loggedInUserDTO.UserId);
				PopUpManager.centerPopUp(cAlert);*/
				
				var userId:int = UtilityFunctions.IsNullOrEmpty( model.loggedInUserDTO )? -1:model.loggedInUserDTO.UserId;
				QSCombinedExceptionAlert.getInstance().Show( model.errorStatus, rpcEvent.toString(), userId); 
				
		}
	}
}