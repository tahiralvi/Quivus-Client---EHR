package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	public class LoginDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoginDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LogIn(username:String,  password:String ) : void {
			var token:AsyncToken = service.AuthenticateUser(username,password);	
			token.addResponder( command );
		}		

	}
}