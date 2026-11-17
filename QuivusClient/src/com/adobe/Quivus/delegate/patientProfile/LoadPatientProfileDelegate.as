package com.adobe.Quivus.delegate.patientProfile
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientProfileDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientProfileDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientProfile(patientId:int , clinicBranchId:int , loddedInUserId:int, sessionDTO:UserSessionDTO ) : void 
		{
			var token:AsyncToken = service.LoadPatientCompleteProfileForClinic(patientId, clinicBranchId, loddedInUserId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}