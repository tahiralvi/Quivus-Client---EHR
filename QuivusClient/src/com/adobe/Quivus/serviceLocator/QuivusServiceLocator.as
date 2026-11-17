package com.adobe.Quivus.serviceLocator
{
	import services.quivusmanagerservice.QuivusManagerService;
	import services.streamingservice.StreamingService;

	public class QuivusServiceLocator
	{
		private static var quivusServiceLocator : QuivusServiceLocator;  
		
		private var quivusManagerServiceInstance	:QuivusManagerService ; 
		private var streamingServiceInstance		:StreamingService ; 
		
		
		
		public function getQuivusManagerServiceInstance() : QuivusManagerService
		{
			if(quivusManagerServiceInstance==null){				
				quivusManagerServiceInstance = new QuivusManagerService();
				quivusManagerServiceInstance.showBusyCursor=true;
			}
					
			return quivusManagerServiceInstance;
		}
		public function getStreamingServiceInstance() : StreamingService
		{
			if(streamingServiceInstance==null){				
				streamingServiceInstance = new StreamingService();
				streamingServiceInstance.showBusyCursor=true;
			}
			
			return streamingServiceInstance;
		}
		
		
		
		public static function getInstance() : QuivusServiceLocator
		{
			if ( quivusServiceLocator == null )
				quivusServiceLocator = new QuivusServiceLocator();
			
			return quivusServiceLocator;
		}
		
		public function QuivusServiceLocator()
		{
			if ( QuivusServiceLocator.quivusServiceLocator != null )
				throw new Error( "Only one quivusServiceLocator instance should be instantiated" );
			
			QuivusServiceLocator.quivusServiceLocator = this;
		}
	}
}