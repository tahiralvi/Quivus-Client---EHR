package com.adobe.Quivus.delegate.viewBackground.allergy
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.PageDTO;
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientAllergyByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientAllergyByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientAllergyByPatientId(patientId:int,sessionDTO:UserSessionDTO, Page:PageDTO) : void {
			var token:AsyncToken = (service ).LoadPatientAllergyByPatientId(patientId,sessionDTO, Page);			
			token.addResponder( command );
		}		

	}
}