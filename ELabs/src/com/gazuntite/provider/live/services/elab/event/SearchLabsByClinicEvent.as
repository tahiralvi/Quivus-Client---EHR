package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	
	public class SearchLabsByClinicEvent extends CairngormEvent
	{
		public var SearchResults:Boolean,
				   pageNo:int, 
				   searchText:String, 
				   fieldID:int;
		
		public function SearchLabsByClinicEvent(searchText:String, pageNo:int, fieldID:int, searchResults:Boolean)
		{
			super(ELabsController.SEARCH_LABS_BY_CLINIC, true, false);
			this.pageNo 			= pageNo; 
			this.searchText 		= searchText; 
			this.fieldID 			= fieldID;
			this.SearchResults 		= searchResults;
		}
	}
}