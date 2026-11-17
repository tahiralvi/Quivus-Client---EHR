package com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.MedicalHistoryDTO;
	import valueObjects.UserSessionDTO;
	
	public class ManagePatientMedicalHistoryDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientMedicalHistoryDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientMedicalHistory(medicalHDTOList:ArrayCollection,session:UserSessionDTO, clinicBrachID:int, patientID:int) : void {
			//var token:AsyncToken =( service as QuivusManagerService ).ManagePatientMedicalHistory(medicalHDTOList,session);
			var token:AsyncToken =( service).ManagePatientMedicalHistory(medicalHDTOList,session, clinicBrachID, patientID);	
			token.addResponder( command );
		}		

	}
}