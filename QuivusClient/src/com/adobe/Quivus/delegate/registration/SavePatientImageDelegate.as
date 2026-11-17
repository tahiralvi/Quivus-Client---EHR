package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.streamingservice.StreamingService;
	
	import valueObjects.ImageDTO;
	import valueObjects.UserSessionDTO;
	
	public class SavePatientImageDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SavePatientImageDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getStreamingServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientImage(imageDTO:ImageDTO, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = (service as StreamingService).InsertUserImage(imageDTO);			
			token.addResponder( command );
		}		
		
	}
}