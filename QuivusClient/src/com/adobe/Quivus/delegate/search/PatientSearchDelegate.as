package com.adobe.Quivus.delegate.search
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class PatientSearchDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function PatientSearchDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function PatientSearch(clinicBranchId:int ,providerId:int,userTypeId:int,searchString:String , pageNo:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.SearchPatientbyClinicIdAndSearchString(clinicBranchId,providerId,userTypeId, searchString, pageNo,sessionDTO);			
			token.addResponder( command );
		}		

	}
}