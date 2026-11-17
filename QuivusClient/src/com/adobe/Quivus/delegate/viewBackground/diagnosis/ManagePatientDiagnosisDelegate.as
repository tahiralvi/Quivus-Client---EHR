package com.adobe.Quivus.delegate.viewBackground.diagnosis
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class ManagePatientDiagnosisDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function ManagePatientDiagnosisDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientDiagnosis(diagnosisList:ArrayCollection,session:UserSessionDTO, clinicBranchID:int, patientID:int) : void {
			var token:AsyncToken =( service ).ManagePatientDiagnosis(diagnosisList,session, clinicBranchID, patientID);			
			token.addResponder( command );
		}		
		
	}
}