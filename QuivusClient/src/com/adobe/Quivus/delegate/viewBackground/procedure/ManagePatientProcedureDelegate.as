package com.adobe.Quivus.delegate.viewBackground.procedure
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.LabDTO;
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManagePatientProcedureDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientProcedureDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientProcedure(inputList:ArrayCollection,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).ManagePatientProcedure(inputList,session);			
			token.addResponder( command );
		}		

	}
}