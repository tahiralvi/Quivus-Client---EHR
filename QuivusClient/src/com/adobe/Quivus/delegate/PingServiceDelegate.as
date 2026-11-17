package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	
	public class PingServiceDelegate
	{
		private var service : Object;
		private var responder:IResponder;
		
		public function PingServiceDelegate(command:IResponder)
		{
			responder = command;
			service = QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
		}
		
		public function PingService():void
		{
			var token:AsyncToken = service.PingAllClientServices();			
			token.addResponder( responder );
		}
	}
}