package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.utils.Constants;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.BaseUserDTO;
	import valueObjects.PatientDTO;
	import valueObjects.UserSessionDTO;
	
	public class RegisterPatientProfileAndLanguageDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function RegisterPatientProfileAndLanguageDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function RegisterPatientProfileAndLanguages(userId: int ,patientDTO : PatientDTO, patientLanguageDTOList: ArrayCollection ,loggedInUserId:int, sessionDTO:UserSessionDTO) : void {
			if(patientDTO.DateOfBirth!=null)	
				patientDTO.StrDOB  = patientDTO.DateOfBirth.toDateString();
			else
				patientDTO.DateOfBirth = Constants.NULL_DATE;
			var token:AsyncToken = service.SavePatientBasicProfileAndLangauge(userId,loggedInUserId,patientDTO,patientLanguageDTOList,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}