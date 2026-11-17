package com.adobe.Quivus.delegate.search.searchEngine
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadUserSearchEngineDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadUserSearchEngineDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadUserSearchEngine(userId:int,  clinicBranchId:int , sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadUserSearchEnginebyLocation(userId,clinicBranchId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}