package com.adobe.Quivus.delegate.staticData.comprehensiveHistory
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadSocialHistoryTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadSocialHistoryTypesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadSocialHistoryTypes(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadSocialHistoryAddictionTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}