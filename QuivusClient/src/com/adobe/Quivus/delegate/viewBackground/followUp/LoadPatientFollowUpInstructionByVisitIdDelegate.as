package com.adobe.Quivus.delegate.viewBackground.followUp
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientFollowUpInstructionByVisitIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientFollowUpInstructionByVisitIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientFollowUpInstructionByVisitId(visitId:int,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).LoadPatientFollowUpInstructionByVisitId(visitId,session);			
			token.addResponder( command );
		}		

	}
}