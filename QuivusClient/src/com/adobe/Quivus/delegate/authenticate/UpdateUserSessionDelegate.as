package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class UpdateUserSessionDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function UpdateUserSessionDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function UpdateUserSession(sessionDTO : UserSessionDTO) : void {
			var token:AsyncToken = (service ).UpdateUserSession(sessionDTO);			
			token.addResponder( command );
		}		

	}
}