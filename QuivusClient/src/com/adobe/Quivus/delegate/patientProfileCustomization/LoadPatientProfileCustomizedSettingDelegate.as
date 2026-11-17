package com.adobe.Quivus.delegate.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientProfileCustomizedSettingDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientProfileCustomizedSettingDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientProfileCustomizedSetting(clinicBranchId:int,  userId:int, patientId:int, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadPatientProfileSettings(clinicBranchId,userId,patientId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}