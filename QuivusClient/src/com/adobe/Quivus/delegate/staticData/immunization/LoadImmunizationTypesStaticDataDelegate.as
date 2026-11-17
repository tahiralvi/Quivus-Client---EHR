package com.adobe.Quivus.delegate.staticData.immunization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadImmunizationTypesStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadImmunizationTypesStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadImmunizationTypesStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadImmunizationTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}