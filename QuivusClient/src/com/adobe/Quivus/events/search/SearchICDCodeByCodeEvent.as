package com.adobe.Quivus.events.search {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class SearchICDCodeByCodeEvent extends CairngormEvent {
		
		
		public var icdCode:String;
		
		public function SearchICDCodeByCodeEvent( icdCode:String ) {
			super( AppController.SEARCH_ICD_CODE_BY_CODE_EVENT);
			this.icdCode = icdCode;
			
			}
		}
	}