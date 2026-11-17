package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class VerifyUserMainDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function VerifyUserMainDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function VerifyUser(userId:int , password:String , session:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).VerifyUser(userId,password,session);			
			token.addResponder( command );
		}		

	}
}