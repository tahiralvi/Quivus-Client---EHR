package com.adobe.Quivus.delegate.viewBackground.vital
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	import valueObjects.VitalDTO;
	
	public class ManagePatientVitalsDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientVitalsDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientVitals(vitalDTOList:ArrayCollection,session:UserSessionDTO) : void {
			var token:AsyncToken = service.ManagePatientVitals(vitalDTOList,session);			
			token.addResponder( command );
		}		

	}
}