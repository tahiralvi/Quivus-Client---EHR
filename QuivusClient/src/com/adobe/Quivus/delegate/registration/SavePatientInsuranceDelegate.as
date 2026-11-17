package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class SavePatientInsuranceDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SavePatientInsuranceDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SavePatientInsurance(patientId:int ,createdByUserId:int ,patientInsuranceDTOList: ArrayCollection, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SavePatientInsuranceInfo(patientId,createdByUserId,patientInsuranceDTOList,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}