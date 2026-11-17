package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	import services.streamingservice.StreamingService;
	
	import valueObjects.PatientAllergyDTO;
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientLabTestsForFollowupByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientLabTestsForFollowupByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientLabTestsForFollowupByPatientId(patientId:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadPatientLabTestsForFollowupByPatient(patientId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}