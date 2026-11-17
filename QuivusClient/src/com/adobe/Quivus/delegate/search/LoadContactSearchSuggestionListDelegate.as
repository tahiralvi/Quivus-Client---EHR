package com.adobe.Quivus.delegate.search
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadContactSearchSuggestionListDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadContactSearchSuggestionListDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadContactSearchSuggestionList(userId:int ,  clinicBranchId:int, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.LoadUsersByClinicBranchID(clinicBranchId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}