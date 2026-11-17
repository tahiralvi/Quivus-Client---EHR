package com.adobe.Quivus.delegate
{
	
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class LogInCombinedDelegate
	{
		private var service : Object;
		private var responder:IResponder;
		
		public function LogInCombinedDelegate(command:IResponder)
		{
			responder = command;
			service = QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
		}
		
		public function LogIn(userName:String, passwd:String, KickOutPreviousSession:Boolean ):void
		{
			var token:AsyncToken = service.LoginModuleCall(userName, passwd, KickOutPreviousSession);			
			token.addResponder( responder );
		}
	}
}