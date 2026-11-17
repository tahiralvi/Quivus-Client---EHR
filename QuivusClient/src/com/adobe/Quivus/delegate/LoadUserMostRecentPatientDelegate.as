package com.adobe.Quivus.delegate
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadUserMostRecentPatientDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadUserMostRecentPatientDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadUserMostRecentPatient(userId:int,  clinicBranchId:int , sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadRecentPatientsByProviderIdAndBranchId(userId,clinicBranchId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}