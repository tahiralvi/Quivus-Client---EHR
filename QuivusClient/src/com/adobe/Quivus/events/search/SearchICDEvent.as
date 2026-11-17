package com.adobe.Quivus.events.search
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SearchICDEvent extends CairngormEvent
	{
		
		public var icdCode:String;
		public var description:String;
		
		public function SearchICDEvent( icdCode:String,description:String ) {
			super( AppController.SEARCH_ICD_EVENT);
			this.icdCode = icdCode;
			this.description = description;
			
		}
		
		
	}
}