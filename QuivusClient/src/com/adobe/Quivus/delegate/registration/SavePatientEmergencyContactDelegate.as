package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.BaseUserDTO;
	import valueObjects.UserSessionDTO;
	
	public class SavePatientEmergencyContactDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SavePatientEmergencyContactDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientEmergencyContact(patientId:int , loggedInUserId:int,patientECList: ArrayCollection, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.ManagePatientEmergencyContact(patientId,loggedInUserId,patientECList,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}