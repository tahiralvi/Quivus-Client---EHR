package com.adobe.Quivus.delegate.email
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class GetEmailByUserIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function GetEmailByUserIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function GetEmailByUserId(userId:int, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.GetUserEmailByUserId(userId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}