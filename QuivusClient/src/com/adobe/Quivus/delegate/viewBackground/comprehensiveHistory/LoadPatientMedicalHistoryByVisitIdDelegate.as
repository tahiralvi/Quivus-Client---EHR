package com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadPatientMedicalHistoryByVisitIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientMedicalHistoryByVisitIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientMedicalHistoryByVisitId(visitId:int,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).LoadPatientMedicalHistoryByVisit(visitId,session);			
			token.addResponder( command );
		}		

	}
}