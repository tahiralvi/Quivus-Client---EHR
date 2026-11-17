package com.adobe.Quivus.delegate.search.searchEngine
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class ChangeDefaultSearchEngineDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ChangeDefaultSearchEngineDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ChangeDefaultSearchEngine( userId : int, clinicBranchId : int ,searchEngineId : int, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SetDefaultSearchEngine(userId,clinicBranchId,searchEngineId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}