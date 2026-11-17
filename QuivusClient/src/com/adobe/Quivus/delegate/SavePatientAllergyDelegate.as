package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.PatientAllergyDTO;
	import valueObjects.UserSessionDTO;
	
	public class SavePatientAllergyDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SavePatientAllergyDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientAllergy(patientID:int,  createdById:int, patientAllergyDTO:PatientAllergyDTO, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SavePatientAllergy(patientID,createdById,patientAllergyDTO,sessionDTO);			
			token.addResponder( command );
		}		

	}
}