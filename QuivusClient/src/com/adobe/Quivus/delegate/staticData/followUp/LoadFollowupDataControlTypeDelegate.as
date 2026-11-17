package com.adobe.Quivus.delegate.staticData.followUp
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadFollowupDataControlTypeDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadFollowupDataControlTypeDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadFollowupDataControlType(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadFollowupDataControlType(sessionDTO);			
			token.addResponder( command );
		}		

	}
}