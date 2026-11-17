package com.adobe.Quivus.delegate.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientProfilePopUpDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientProfilePopUpDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientProfilePopUpData(patientId:int , clinicBranchId:int ,providerUserId:int , sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadPatientProfileInfoForProvider(patientId,clinicBranchId,providerUserId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}