package com.adobe.Quivus.delegate.viewBackground.immunization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.ImmunizationDTO;
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientVisitImmunizationDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientVisitImmunizationDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientVisitImmunization(visitId:int,providerUserId:int , userTypeId:int, sessionDTO:UserSessionDTO  ) : void {
			var token:AsyncToken = service.LoadImmunizationsByVisitId(visitId,providerUserId,userTypeId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}