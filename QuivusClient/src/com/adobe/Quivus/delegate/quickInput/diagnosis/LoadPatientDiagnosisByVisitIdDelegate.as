package com.adobe.Quivus.delegate.quickInput.diagnosis
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientDiagnosisByVisitIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadPatientDiagnosisByVisitIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientDiagnosisByVisitId(visitId:int,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).LoadPatientDiagnosisByVisitId(visitId,session);
			token.addResponder( command );
		}		
		
	}
}