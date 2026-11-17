package com.adobe.Quivus.events.search {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class SearchAllergyTypeByNameEvent extends CairngormEvent {
		
		
		public var allergyTypeName:String;
		
		public function SearchAllergyTypeByNameEvent( allergyTypeName:String ) {
			super( AppController.SEARCH_ALLERGY_TYPE_BY_NAME_EVENT);
			this.allergyTypeName = allergyTypeName;
			
			}
		}
	}