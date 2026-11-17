package com.adobe.Quivus.delegate.staticData.addressBook
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadZipcodesByStateIdAndCityNameDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadZipcodesByStateIdAndCityNameDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function loadZipcodesByStateIdAndCityName(stateId:int , cityName:String, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.GetZipCodesByStateIdAndCityName(stateId,cityName,sessionDTO);			
			token.addResponder( command );
		}		

	}
}