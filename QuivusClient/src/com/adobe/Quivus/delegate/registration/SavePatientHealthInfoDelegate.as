package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.PatientHealthDTO;
	import valueObjects.UserSessionDTO;
	
	public class SavePatientHealthInfoDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SavePatientHealthInfoDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientHealthInfo(patientId:int ,loggedInUserId:int ,healthHX: PatientHealthDTO, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SavePatientHealthInfo(patientId,loggedInUserId,healthHX,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}