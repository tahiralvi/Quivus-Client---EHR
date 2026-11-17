package com.adobe.Quivus.delegate.ePrescription
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class SyncEPrescriptionDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SyncEPrescriptionDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SyncEPrescriptionWithEPresService(visitId:int,patientId:int , rcopiaID:String , clinicBranchID:int , userSession:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).SyncEPrescription(patientId,rcopiaID,clinicBranchID,visitId,userSession );			
			token.addResponder( command );
		}		

	}
}