package com.adobe.Quivus.delegate.ePrescription
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class PrepareLoginCallForEprescriptionDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function PrepareLoginCallForEprescriptionDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function PrepareLoginCallForEprescription(userId:String ,patientId:int ,sessionDTO:UserSessionDTO ) : void {
		//	var token:AsyncToken = (service ).PrepareLoginCallForEprescription(userId,patientId,sessionDTO );			
		//	token.addResponder( command );
		}		

	}
}