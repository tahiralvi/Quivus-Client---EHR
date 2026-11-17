package com.adobe.Quivus.delegate.patientProfileCustomization
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.PatientProfileSettingDTO;
	import valueObjects.UserSessionDTO;
	
	public class ManageUserPatientProfileBarSettingDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManageUserPatientProfileBarSettingDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManageUserPatientProfileBarSetting(profileSettingObj:PatientProfileSettingDTO, sessionDTO:UserSessionDTO  ) : void {
			var token:AsyncToken = service.ManagePatientProfileSettings(profileSettingObj,sessionDTO);			
			token.addResponder( command );
		}		

	}
}