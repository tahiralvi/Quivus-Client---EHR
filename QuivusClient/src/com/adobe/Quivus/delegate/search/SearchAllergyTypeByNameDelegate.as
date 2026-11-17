package com.adobe.Quivus.delegate.search
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.UserSessionDTO;
	
	public class SearchAllergyTypeByNameDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
	
		public function SearchAllergyTypeByNameDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SearchAllergyTypeByName( allergyTypeName:String, sessionDTO:UserSessionDTO) : void {
			var token:AsyncToken = service.SearchAllergyTypeByName(allergyTypeName,sessionDTO);			
			token.addResponder( command );
		}		

	}
}