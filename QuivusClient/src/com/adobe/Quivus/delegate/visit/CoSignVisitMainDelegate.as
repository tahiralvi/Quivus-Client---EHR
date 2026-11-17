package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class CoSignVisitMainDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function CoSignVisitMainDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function CoSignVisit(visitId:int , providerId:int , sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = (service ).CoSignVisit(visitId,providerId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}