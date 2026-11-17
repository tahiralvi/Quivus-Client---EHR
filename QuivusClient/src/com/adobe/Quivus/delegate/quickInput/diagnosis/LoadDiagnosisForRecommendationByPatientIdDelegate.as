package com.adobe.Quivus.delegate.quickInput.diagnosis
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadDiagnosisForRecommendationByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadDiagnosisForRecommendationByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadDiagnosisForRecommendationByPatientId(patientId:int,cbId:int,session:UserSessionDTO) : void {
			//var token:AsyncToken =( service as QuivusManagerService).LoadPatientDiagnosisByPatientId(patientId,session);
			var token:AsyncToken =( service ).LoadPatientDiagnosisByPatientIdANDForRecommendation (patientId,cbId,session);
			token.addResponder( command );
		}		
		
	}
}