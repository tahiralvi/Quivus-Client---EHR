package com.adobe.Quivus.delegate.viewBackground.document
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class SearchPatientDocumentByPatientIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SearchPatientDocumentByPatientIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SearchPatientDocumentByPatientId(patientId:int,cbId:int,session:UserSessionDTO,pageNo:int,searchText:String,fieldId:int) : void {
			var token:AsyncToken =(service ).SearchPatientDocumentByClinicIdAndPatientID(session,cbId,searchText,fieldId,pageNo,patientId);			
			token.addResponder( command );
		}		

	}
}