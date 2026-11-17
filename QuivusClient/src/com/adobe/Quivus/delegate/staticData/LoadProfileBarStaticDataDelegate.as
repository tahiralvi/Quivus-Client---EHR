package com.adobe.Quivus.delegate.staticData
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadProfileBarStaticDataDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadProfileBarStaticDataDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadProfileBarStaticData( sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadProfileStaticData(sessionDTO);			
			token.addResponder( command );
		}		

	}
}