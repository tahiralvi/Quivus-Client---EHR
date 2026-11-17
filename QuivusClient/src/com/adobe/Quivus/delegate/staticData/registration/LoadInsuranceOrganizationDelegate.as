package com.adobe.Quivus.delegate.staticData.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadInsuranceOrganizationDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadInsuranceOrganizationDelegate(command : IResponder)
		{
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;	
		}
		
		public function LoadInsuranceOrganization(dataToLoad:ArrayCollection , sessionDTO:UserSessionDTO):void
		{
			var token:AsyncToken = service.GetRegisterationStaticDataByType(dataToLoad,sessionDTO);
			//var token:AsyncToken = service.GetRegisterationStaticData();
			token.addResponder( command );
		}
	}
}