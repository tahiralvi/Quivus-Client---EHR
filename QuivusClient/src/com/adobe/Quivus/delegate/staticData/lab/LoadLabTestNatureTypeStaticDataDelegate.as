package com.adobe.Quivus.delegate.staticData.lab
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadLabTestNatureTypeStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadLabTestNatureTypeStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadLabTestNatureTypeStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadLabNatureTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}