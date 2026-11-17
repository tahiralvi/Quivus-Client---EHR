package com.adobe.Quivus.delegate.registration
{
	import com.adobe.Quivus.delegate.BaseDelegate;
	import com.adobe.Quivus.serviceLocator.QuivusServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import valueObjects.AddressBookDTO;
	import valueObjects.UserSessionDTO;
	
	public class SaveAddressBookDelegate extends BaseDelegate
	{
		private var command : IResponder;
		private var service : Object;
		
		public function SaveAddressBookDelegate(  command : IResponder )
		{		
			this.service =  QuivusServiceLocator.getInstance().getQuivusManagerServiceInstance();
			this.command = command;				
		}
		
		public function SaveAddressBook(patientId:int , loggedInUserId:int,addressBookDTO: AddressBookDTO, sessionDTO:UserSessionDTO ) : void {
			var token:AsyncToken = service.SaveAddressBook(patientId,loggedInUserId,addressBookDTO,sessionDTO);			
			token.addResponder( command );
		}		
		
	}
}