package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	import com.adobe.Quivus.delegate.BaseDelegate;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.quivusmanagerservice.QuivusManagerService;
	
	import valueObjects.UserSessionDTO;
	import valueObjects.VisitDTO;
	
	public class UpdateVisitDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function UpdateVisitDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function UpdateVisit(visitDTO:VisitDTO,logginUserId:int,userTypeId:int,session:UserSessionDTO) : void {
			
			//var token:AsyncToken =( service as QuivusManagerService).SaveVisit(visitDTO,userTypeId,logginUserId,session);
			//Changes by baber 
			// replace above mention code line with the following line in the next live build with server is also depolyed 20 may 2011
			var token:AsyncToken =( service ).SaveVisit(visitDTO,logginUserId,session);
			token.addResponder( command );
		}		

	}
}