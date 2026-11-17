package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class SignVisitMainDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SignVisitMainDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SignVisit(visitId:int , loggedInuserId:int , sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).SignVisit(visitId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}