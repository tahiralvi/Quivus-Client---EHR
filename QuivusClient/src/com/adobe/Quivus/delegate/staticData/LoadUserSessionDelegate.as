package com.adobe.Quivus.delegate.staticData
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class LoadUserSessionDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		
		public function LoadUserSessionDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadSearchByTypeStaticData() : void 
		{
			var token:AsyncToken =  (service ).LoadUserSessionStatus();			
			token.addResponder( command );
		}		
	
	}
}