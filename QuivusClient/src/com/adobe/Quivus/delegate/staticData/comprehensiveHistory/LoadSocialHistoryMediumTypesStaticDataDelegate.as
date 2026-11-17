package com.adobe.Quivus.delegate.staticData.comprehensiveHistory
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadSocialHistoryMediumTypesStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadSocialHistoryMediumTypesStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadSocialHistoryMediumTypesStaticData(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadSocialHistoryMediumTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}