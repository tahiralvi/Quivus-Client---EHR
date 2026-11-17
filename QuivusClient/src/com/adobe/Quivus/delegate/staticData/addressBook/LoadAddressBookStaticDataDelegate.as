package com.adobe.Quivus.delegate.staticData.addressBook
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadAddressBookStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadAddressBookStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadAddressBookStaticData(  sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.GetAddressBookStaticData(sessionDTO);			
			token.addResponder( command );
		}		

	}
}