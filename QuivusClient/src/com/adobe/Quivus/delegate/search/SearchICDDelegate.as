package com.adobe.Quivus.delegate.search
{
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class SearchICDDelegate
	{
		private var command : IResponder;
		private var service : Object;
		public function SearchICDDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
	
		public function SearchICDCode( icdCode:String,description:String) : void {
			var token:AsyncToken = service.SearchICD(icdCode,description);			
			token.addResponder( command );
		}		
	}
}