package com.adobe.Quivus.delegate.authenticate
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	public class LoginSuccessfullDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoginSuccessfullDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SendLoginDataToLog(userId : int, userTypeId : int,clinicBranchId : int ) : void {
			var token:AsyncToken = service.LogLoginHistory(userId,userTypeId,clinicBranchId,true);			
			token.addResponder( command );
		}		

	}
}