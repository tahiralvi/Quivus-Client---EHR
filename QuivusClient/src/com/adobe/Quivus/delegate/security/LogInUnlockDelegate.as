package com.adobe.Quivus.delegate.security
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class LogInUnlockDelegate
	{
		private var service : Object;
		private var responder:IResponder;
		
		public function LogInUnlockDelegate(command:IResponder)
		{
			responder = command;
			service = QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
		}
		
		public function LogInUnlock(userName:String, passwd:String, KickOutPreviousSession:Boolean ):void
		{
			var token:AsyncToken = service.LoginModuleCall(userName, passwd, KickOutPreviousSession);			
			token.addResponder( responder );
		}
	}
}