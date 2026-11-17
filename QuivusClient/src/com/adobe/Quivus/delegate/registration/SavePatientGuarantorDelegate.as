package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.PatientGuarantorDTO;
	import valueObjects.UserSessionDTO;
	
	public class SavePatientGuarantorDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SavePatientGuarantorDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientGuarantor(patientId:int , loggedInUserId:int,patientGuarantorDTOList: ArrayCollection, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SavePatientGurantor(patientId,loggedInUserId,patientGuarantorDTOList,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}