package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.streamingservice.StreamingService;
	
	import valueObjects.PatientAllergyDTO;
	import valueObjects.UserSessionDTO;
	
	public class LoadLoggedInUserImageDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadLoggedInUserImageDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getStreamingServiceInstance();
			this.command = command;				
		}
		
		public function LoadLoggedInUserImage(userId:int, userTypeID:int , sessionDTO:UserSessionDTO) : void {
			//TO Do - baber waqas implemented 
			/*var token:AsyncToken = (service as StreamingService).LoadUserImage(userId,userTypeID);			
			token.addResponder( command );*/
		}		

	}
}