package com.adobe.Quivus.delegate.visit
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.PageDTO;
	
	public class LoadPatientVisitsByProviderIDDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadPatientVisitsByProviderIDDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function LoadPatientVisitsByProviderID(pageDTO:PageDTO, strUserId:String, strclinicBranchId:String, strshowAll:String) : void 
		{
			var token:AsyncToken = service.LoadPatientVisitsByProviderID(pageDTO, strUserId, strclinicBranchId, strshowAll)
			token.addResponder( command );
		}	
	}
}