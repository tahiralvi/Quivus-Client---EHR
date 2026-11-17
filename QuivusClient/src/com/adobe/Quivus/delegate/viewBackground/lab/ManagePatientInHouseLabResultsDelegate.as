package com.adobe.Quivus.delegate.viewBackground.lab
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import flash.utils.ByteArray;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	
	public class ManagePatientInHouseLabResultsDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientInHouseLabResultsDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientInHouseLabResults(pateintInHouseResultId:int,testRerult:String,attchArray:ByteArray,modifiedBy:int,modifiedAt:Date,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).ManagePatientInHouseLabResults(pateintInHouseResultId,testRerult,attchArray,modifiedBy,modifiedAt,session);			
			token.addResponder( command );
		}		

	}
}