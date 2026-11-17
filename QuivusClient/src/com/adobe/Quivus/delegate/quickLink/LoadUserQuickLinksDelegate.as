package com.adobe.Quivus.delegate.quickLink
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadUserQuickLinksDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadUserQuickLinksDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadUserQuickLinks(userId : int, clinicBranchId : int , sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.LoadUserDefaultQuickLinksbyLocation(userId,clinicBranchId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}