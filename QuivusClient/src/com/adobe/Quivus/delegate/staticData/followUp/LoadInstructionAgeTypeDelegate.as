package com.adobe.Quivus.delegate.staticData.followUp
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadInstructionAgeTypeDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadInstructionAgeTypeDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadInstructionAgeType(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadInstructionAgeType(sessionDTO);			
			token.addResponder( command );
		}		

	}
}