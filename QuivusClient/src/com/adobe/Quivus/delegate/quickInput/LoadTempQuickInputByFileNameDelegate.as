package com.adobe.Quivus.delegate.quickInput
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.QuickInputDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	
	public class LoadTempQuickInputByFileNameDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadTempQuickInputByFileNameDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadTempQuickInputByFileName(fileName:String, session:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).LoadTempQI(fileName, session);			
			token.addResponder( command );
		}		

	}
}