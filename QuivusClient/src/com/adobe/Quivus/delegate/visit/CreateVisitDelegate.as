package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class CreateVisitDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function CreateVisitDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function CreateNewVisit(visitDTO:VisitDTO,logginUserId:int,session:UserSessionDTO) : void {
			var token:AsyncToken =( service ).CreateVisit(visitDTO,logginUserId,session);			
			token.addResponder( command );
		}		

	}
}