package com.adobe.Quivus.events.registration
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.AddressBookDTO;

	public class SaveAddressBookEvent extends CairngormEvent 
	{
		public var addressBookDTO : AddressBookDTO;
		public var patientId : int;
		public var functionName : Function;
		public var purpose		: String;
		
		public function SaveAddressBookEvent(purpose : String,patientId : int,addressBookDTO : AddressBookDTO,functionName : Function = null)
		{
			super( AppController.SAVE_ADDRESS_BOOK_EVENT);
			this.addressBookDTO = addressBookDTO;
			this.patientId = patientId;
			this.purpose = purpose;
			this.functionName = functionName;
		}
	}
}