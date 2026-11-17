package com.adobe.Quivus.delegate.staticData
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadSearchByTypeStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadSearchByTypeStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadSearchByTypeStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadSearchField(sessionDTO);			
			token.addResponder( command );
		}		

	}
}