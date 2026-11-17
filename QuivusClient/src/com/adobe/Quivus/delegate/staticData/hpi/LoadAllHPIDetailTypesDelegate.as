package com.adobe.Quivus.delegate.staticData.hpi
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadAllHPIDetailTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadAllHPIDetailTypesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadAllHPIDetailTypes(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadHPIDetailTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}