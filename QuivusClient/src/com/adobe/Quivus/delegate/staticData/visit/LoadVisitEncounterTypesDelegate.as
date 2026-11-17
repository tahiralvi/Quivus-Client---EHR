package com.adobe.Quivus.delegate.staticData.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadVisitEncounterTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadVisitEncounterTypesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadVisitEncounterTypes( sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.LoadEncounterTypes(sessionDTO);			
			token.addResponder( command );
		}		

	}
}