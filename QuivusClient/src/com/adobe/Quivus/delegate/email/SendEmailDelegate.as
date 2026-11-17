package com.adobe.Quivus.delegate.email
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	import services.streamingservice.StreamingService;
	
	import valueObjects.EmailDTO;
	import valueObjects.UserSessionDTO;
	
	public class SendEmailDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SendEmailDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getStreamingServiceInstance();
			this.command = command;				
		}
		
		public function SendEmail(emailDTO:EmailDTO, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service as StreamingService).SendEmail(emailDTO);			
			token.addResponder( command );
		}		

	}
}