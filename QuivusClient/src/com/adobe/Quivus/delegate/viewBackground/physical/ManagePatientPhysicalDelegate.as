package com.adobe.Quivus.delegate.viewBackground.physical
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManagePatientPhysicalDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientPhysicalDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientPhysical(list:ArrayCollection,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).ManagePatientPhysical(list,session);			
			token.addResponder( command );
		}		

	}
}