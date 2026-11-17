package com.adobe.Quivus.delegate.staticData.recommendation.procedure
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadCPTMedicalTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadCPTMedicalTypesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadCPTMedicalTypes(cptName:String, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadCPTMedicalTypes(cptName,sessionDTO);			
			token.addResponder( command );
		}		

	}
}