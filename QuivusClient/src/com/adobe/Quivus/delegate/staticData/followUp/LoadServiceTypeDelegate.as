package com.adobe.Quivus.delegate.staticData.followUp
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadServiceTypeDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadServiceTypeDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadServiceType(followupDataControlTypeID:int,brachID:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = (service ).LoadPatientFollowupAutoCompleteByTypeIdAndClinicId(followupDataControlTypeID,brachID, sessionDTO);			
			token.addResponder( command );
		}		

	}
}