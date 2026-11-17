package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class ImportVisitByPateintIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ImportVisitByPateintIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ImportVisitByPateintId(templateID:int , clinicBranchId:int, patientId:int , sessionDTO:UserSessionDTO ) : void {
			
			var token:AsyncToken = service.ImportVisitByTemplate(templateID, clinicBranchId, sessionDTO);			
			token.addResponder( command );
		}		

	}
}