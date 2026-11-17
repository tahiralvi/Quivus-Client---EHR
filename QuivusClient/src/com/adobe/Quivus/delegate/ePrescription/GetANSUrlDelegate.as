package com.adobe.Quivus.delegate.ePrescription
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class GetANSUrlDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function GetANSUrlDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function GetANSUrl(practiceName:String , sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).GetANSUrl(practiceName,sessionDTO );			
			token.addResponder( command );
		}		

	}
}