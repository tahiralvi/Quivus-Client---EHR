package com.adobe.Quivus.delegate.staticData.lab
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadLabTestPriorityTypeStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadLabTestPriorityTypeStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadLabTestPriorityTypeStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadLabTestPriorityTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}