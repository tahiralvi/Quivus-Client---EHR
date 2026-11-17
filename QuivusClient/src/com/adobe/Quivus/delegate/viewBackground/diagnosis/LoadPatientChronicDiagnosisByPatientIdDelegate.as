package com.adobe.Quivus.delegate.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientChronicDiagnosisByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadPatientChronicDiagnosisByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientChronicDiagnosisByPatientId(patientId:int,cbId:int,session:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean) : void {
			var token:AsyncToken =( service ).LoadPatientChronicDiagnosisByPatientId(patientId,cbId,session,stationIds,isallSelected);			
			token.addResponder( command );
		}		
		
	}
}