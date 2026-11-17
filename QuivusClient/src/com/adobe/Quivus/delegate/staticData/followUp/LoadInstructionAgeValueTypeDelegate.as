package com.adobe.Quivus.delegate.staticData.followUp
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadInstructionAgeValueTypeDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadInstructionAgeValueTypeDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadInstructionAgeValueType(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadInstructionAgeValueType(sessionDTO);			
			token.addResponder( command );
		}		

	}
}