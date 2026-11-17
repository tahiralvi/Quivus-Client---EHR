package com.adobe.Quivus.delegate.viewBackground.ros
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class ManagePatientROSDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManagePatientROSDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManagePatientROS(rosList:ArrayCollection,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).ManagePatientROS(rosList,session);			
			token.addResponder( command );
		}		

	}
}