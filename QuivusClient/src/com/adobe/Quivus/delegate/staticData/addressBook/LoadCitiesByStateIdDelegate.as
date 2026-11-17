package com.adobe.Quivus.delegate.staticData.addressBook
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadCitiesByStateIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadCitiesByStateIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadCitiesByStateId(stateId:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.GetCityListByState(stateId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}