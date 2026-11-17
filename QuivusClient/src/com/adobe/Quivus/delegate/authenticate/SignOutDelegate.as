package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class SignOutDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SignOutDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SignOut(sessionDTO : UserSessionDTO) : void {
			var token:AsyncToken = (service ).SignOutUserSession(sessionDTO.SessionID);			
			token.addResponder( command );
		}		

	}
}