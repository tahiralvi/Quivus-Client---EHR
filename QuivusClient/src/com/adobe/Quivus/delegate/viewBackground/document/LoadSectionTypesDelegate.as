package com.adobe.Quivus.delegate.viewBackground.document
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class LoadSectionTypesDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function LoadSectionTypesDelegate( command : IResponder)
		{
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;	
		}
		
		public function LoadSectionTypes(session:UserSessionDTO) : void {
			var token:AsyncToken =(service ).LoadDocumentSectionTypes(session);			
			token.addResponder( command );
		}
	}
}