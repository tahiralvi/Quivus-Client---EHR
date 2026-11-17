package com.adobe.Quivus.delegate.viewBackground.document
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadPatientDocumentByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadPatientDocumentByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientDocumentByPatientId(patientId:int,cbId:int,session:UserSessionDTO,pageNo:int) : void {
			var token:AsyncToken =(service ).LoadPatientDocumentByClinicIdAndPatientID(cbId,patientId,pageNo,session);			
			token.addResponder( command );
		}		

	}
}