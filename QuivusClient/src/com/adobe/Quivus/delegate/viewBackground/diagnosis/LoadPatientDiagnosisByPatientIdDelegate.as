package com.adobe.Quivus.delegate.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientDiagnosisByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadPatientDiagnosisByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientDiagnosisByPatientId(patientId:int,cbId:int,session:UserSessionDTO,stationIds:ArrayCollection,isallSelected:Boolean) : void {
			//var token:AsyncToken =( service as QuivusManagerService).LoadPatientDiagnosisByPatientId(patientId,session);			
			var token:AsyncToken =( service ).LoadPatientAllDiagnosisByPatientId(patientId,cbId,session,stationIds,isallSelected);
			token.addResponder( command );
		}		
		
	}
}