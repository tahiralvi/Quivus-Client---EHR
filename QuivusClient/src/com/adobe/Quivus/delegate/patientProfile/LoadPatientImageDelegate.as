package com.adobe.Quivus.delegate.patientProfile
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.streamingservice.StreamingService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientImageDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientImageDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getStreamingServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientImage(userId:int , userTypeId:int,sessionDTO:UserSessionDTO ) : void {
			
			var token:AsyncToken = (service as StreamingService).LoadUserImage(userId,userTypeId );			
			token.addResponder( command );
		}		

	}
}