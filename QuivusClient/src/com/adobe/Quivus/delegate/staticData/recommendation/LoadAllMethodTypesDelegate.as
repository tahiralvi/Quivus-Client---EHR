package com.adobe.Quivus.delegate.staticData.recommendation
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadAllMethodTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadAllMethodTypesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadAllMethodTypes(sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadAllRecommendationMethodTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}