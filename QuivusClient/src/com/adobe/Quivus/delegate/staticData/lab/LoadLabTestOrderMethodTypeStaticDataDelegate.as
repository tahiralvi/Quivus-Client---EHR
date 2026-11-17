package com.adobe.Quivus.delegate.staticData.lab
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadLabTestOrderMethodTypeStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadLabTestOrderMethodTypeStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadLabTestOrderMethodTypeStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadLabTestOrderMethodTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}