package com.gazuntite.provider.live.services.administration.delegate.userManagement
{
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class SaveAddressDelegate
	{
		private var responder	:IResponder;
		private var service		:HTTPService;
		
		
		
		public function SaveAddressDelegate( responder : IResponder )
		{
			this.responder 		= responder;
			
			//var url:String 		= "http://www.quivus.com/QuivusAirDev/UserService/Service/RestfulService/UserManagerRestfulService.svc/UpdateUser";
			//http://www.quivus.com/QuivusAirDev/AddressBookService/AddressBookRestfullService/AddressBookERestfullService.svc/SaveUserAddressBook/599
			//var url:String 		= EConstants.RESTFULL_USER_SERVICE_BASE_URL + "UpdateUser";
			var url:String 		= "http://www.quivus.com/QuivusAirDev/AddressBookService/AddressBookRestfullService/AddressBookERestfullService.svc/SaveUserAddressBook/599";
			
			service 			= new HTTPService(url);
			service.url 		= url;
			
			service.contentType = "Text/Xml";
			service.method		= "POST";
			
			
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.addEventListener(ResultEvent.RESULT,onResult);
			
		}
	
		public function SaveAddress(data:XML, date:Date):void
		{
			trace("Save Address");
			trace("Save Address XML before passing to service", data.toXMLString());
			
			var df:DateFormatter = new DateFormatter();
			df.formatString = "MM-DD-YYYY";
			var d:String = df.format( date );
			//service.url += "/" + d;			
			
			var data1:XML = <AddressBookDTO IsDeleted="false" IsDirty="false" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<AddressBookID>0</AddressBookID>
<AddressDTOlist>
<AddressDTO IsDeleted="false" IsDirty="false">
<AddressID>0</AddressID>
<AddressBookID>0</AddressBookID>
<OwnerTypeID>0</OwnerTypeID>
<AddressTypeID>0</AddressTypeID>
<IsPrimary>false</IsPrimary>
<ZipCodeID>0</ZipCodeID>
<CityCode>asd</CityCode>
<StateID>0</StateID><CountryID>0</CountryID>
<AddressPhoneDTOlist>
<AddressPhoneDTO IsDeleted="false" IsDirty="false">
<AddressPhoneID>0</AddressPhoneID>
<PhoneDTO IsDeleted="false" IsDirty="false">
<PhoneID>0</PhoneID>
<AddressBookID>0</AddressBookID>
<PhoneTypeID>0</PhoneTypeID>
<NumberTypeID>0</NumberTypeID>
<OwnerTypeID>0</OwnerTypeID>
<PhoneNumber>asdsa</PhoneNumber>
<IsPrimary>false</IsPrimary>
<CreatedBy>0</CreatedBy>
<CreatedAt>0001-01-01T00:00:00</CreatedAt>
<UpdatedBy>0</UpdatedBy>
<UpdatedAt>0001-01-01T00:00:00</UpdatedAt>
</PhoneDTO><PhoneID>1</PhoneID>
<AddressID>0</AddressID>
<CreatedBy>0</CreatedBy>
<CreatedAt>0001-01-01T00:00:00</CreatedAt>
<UpdatedBy>0</UpdatedBy>
<UpdatedAt>0001-01-01T00:00:00</UpdatedAt>
</AddressPhoneDTO></AddressPhoneDTOlist>
<CreatedBy>0</CreatedBy>
<CreatedAt>0001-01-01T00:00:00</CreatedAt>
<UpdatedBy>0</UpdatedBy>
<UpdatedAt>0001-01-01T00:00:00</UpdatedAt>
</AddressDTO>
</AddressDTOlist>
<PhoneDTOlist/>
<PartyID>00000000-0000-0000-0000-000000000000</PartyID>
<AddressPartyTypeID>0</AddressPartyTypeID>
<CreatedBy>0</CreatedBy>
<CreatedAt>0001-01-01T00:00:00</CreatedAt>
<UpdatedBy>0</UpdatedBy>
<UpdatedAt>0001-01-01T00:00:00</UpdatedAt>
</AddressBookDTO>
			
			service.send(data1);
		}
		

		
		private function onResult(event:ResultEvent):void
		{
			responder.result(event);
			trace("SaveAddressDelegate -- > result for call:<br>" + service.url + "<br> " + event.result.toString());
		
		
		}
		
		private function onFault(event:FaultEvent):void
		{
			responder.fault(event);	
			trace("SaveAddressDelegate -- > fault for call:<br>" + service.url + "<br> " + event.fault);
		}
		
		
	}
}