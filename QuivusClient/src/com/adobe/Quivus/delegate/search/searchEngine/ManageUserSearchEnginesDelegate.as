package com.adobe.Quivus.delegate.search.searchEngine
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class ManageUserSearchEnginesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function ManageUserSearchEnginesDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function ManageUserSearchEngines(loggedInUserId:int , ClinicBranchID:int
												, SearchEngineTypeIdList:ArrayCollection, CreatedBy:int, sessionDTO:UserSessionDTO  ) : void {
			var token:AsyncToken = service.ManageUserSearchEngine(loggedInUserId,ClinicBranchID,SearchEngineTypeIdList,CreatedBy,sessionDTO);			
			token.addResponder( command );
		}
		
		public function ManageUserSearchEnginesDeleteAll(loggedInUserId:int , ClinicBranchID:int
												        , CreatedBy:int, sessionDTO:UserSessionDTO  ) : void {
			
			var token:AsyncToken = service.ClearUserAddedSearchEngines(loggedInUserId,ClinicBranchID,CreatedBy,sessionDTO);			
			token.addResponder( command );
		}		


	}
}