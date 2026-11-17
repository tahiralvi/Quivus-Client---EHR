package com.adobe.Quivus.delegate.staticData.lab
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadLIONICLabTestTypeDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadLIONICLabTestTypeDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadLIONICLabTestType(labtestTypeID:int, labTestCodeOrName:String,sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadLIONICLabTestType(labtestTypeID,labTestCodeOrName,sessionDTO);			
			token.addResponder( command );
		}		

	}
}