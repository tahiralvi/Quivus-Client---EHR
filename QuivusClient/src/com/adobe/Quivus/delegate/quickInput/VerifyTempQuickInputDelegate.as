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
	
	
	public class VerifyTempQuickInputDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function VerifyTempQuickInputDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function VerifyTempQuickInput(fileName:String, session:UserSessionDTO ) : void {
		//	var token:AsyncToken = (service ).IsTempQIExists(fileName, session);			
		//	token.addResponder( command );
		}		

	}
}