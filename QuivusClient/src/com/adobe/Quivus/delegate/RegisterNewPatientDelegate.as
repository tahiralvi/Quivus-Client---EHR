package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.RegistrationDTO;
	import valueObjects.UserDTO;
	
	[Deprecated("this registers a patient in one call, but currently, registration is done in multiple-calls")]
	public class RegisterNewPatientDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function RegisterNewPatientDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function registerNewPatient(registrationDTO:RegistrationDTO ) : void {
					
			registrationDTO.User._PatientDTO.DateOfBirth = new Date();
			registrationDTO.User.CreatedDate = new Date();
			registrationDTO.User._PatientDTO.CreatedDate = new Date();
			registrationDTO.User._PatientDTO.RecGuid= Constants.GUID_FORMAT ;
			
			var token:AsyncToken = service.RegisterNewUser(registrationDTO);			
			token.addResponder( command );
		}		

	}
}