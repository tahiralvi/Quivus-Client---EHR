package com.adobe.Quivus.events.staticData.addressBook {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAddressBookStaticDataEvent extends CairngormEvent {
		
		

		public function LoadAddressBookStaticDataEvent(  ) {
			super( AppController.LOAD_ADDRESS_BOOK_STATIC_DATA_EVENT);
			
			}
		}
	}