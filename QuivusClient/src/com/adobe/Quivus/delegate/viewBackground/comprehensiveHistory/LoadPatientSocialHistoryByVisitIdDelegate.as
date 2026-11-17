package com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadPatientSocialHistoryByVisitIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientSocialHistoryByVisitIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientSocialHistoryByVisitId(visitId:int,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).LoadSocialHistoryByVisitId(visitId,session);			
			token.addResponder( command );
		}		

	}
}