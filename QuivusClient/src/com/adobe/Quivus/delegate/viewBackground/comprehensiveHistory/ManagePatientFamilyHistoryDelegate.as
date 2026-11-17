package com.adobe.Quivus.delegate.viewBackground.comprehensiveHistory
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.FamilyHistoryDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManagePatientFamilyHistoryDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientFamilyHistoryDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientFamilyHistory(familyHDTOList:ArrayCollection,session:UserSessionDTO, clinicBranchId:int, patientID:int) : void {
			var token:AsyncToken =( service ).ManagePatientFamilyHistory(familyHDTOList,session, clinicBranchId, patientID);			
			token.addResponder( command );
		}		

	}
}