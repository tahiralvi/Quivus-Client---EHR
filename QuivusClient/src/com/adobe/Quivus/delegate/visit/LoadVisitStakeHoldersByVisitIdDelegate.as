package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadVisitStakeHoldersByVisitIdDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function LoadVisitStakeHoldersByVisitIdDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadVisitStakeHoldersByVisitId(visitId:int , sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.LoadVisitStakeHolderByVisitId(visitId,sessionDTO);			
			token.addResponder( command );
		}		

	}
}