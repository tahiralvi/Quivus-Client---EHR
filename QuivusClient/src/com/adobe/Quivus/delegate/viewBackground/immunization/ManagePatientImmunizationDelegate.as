package com.adobe.Quivus.delegate.viewBackground.immunization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.ImmunizationDTO;
	import valueObjects.UserSessionDTO;
	// for view-background
	public class ManagePatientImmunizationDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientImmunizationDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientImmunization(immunizationDTOList:ArrayCollection , sessionDTO:UserSessionDTO, clinicBranchID:int, patientID:int) : void {
			var token:AsyncToken = service.ManagePatientImmunization(immunizationDTOList,sessionDTO, clinicBranchID, patientID);			
			token.addResponder( command );
		}		

	}
}