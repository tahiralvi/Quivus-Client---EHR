package com.adobe.Quivus.delegate.ePrescription
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class GetUrlForEditAllergiesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function GetUrlForEditAllergiesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function GetUrlForEditAllergies(userId:String,patientId:String,clinicName:String,userEmail:String, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).GetUrlForEditAllergies(userId,patientId,clinicName,userEmail,sessionDTO );			
			token.addResponder( command );
		}		

	}
}