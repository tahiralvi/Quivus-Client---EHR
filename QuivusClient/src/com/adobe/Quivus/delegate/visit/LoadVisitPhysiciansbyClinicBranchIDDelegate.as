package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class LoadVisitPhysiciansbyClinicBranchIDDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadVisitPhysiciansbyClinicBranchIDDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadVisitPhysiciansbyClinicBranchID(ClinicBranchID:int, VisitID:int, PatientID:int, isEditMode:Boolean, loggedinUserID:int) : void 
		{
			var token:AsyncToken =( service ).LoadPhysiciansbyClinicBranchID(ClinicBranchID, VisitID, PatientID, isEditMode, loggedinUserID);			
			token.addResponder( command );
		}		
	}
}