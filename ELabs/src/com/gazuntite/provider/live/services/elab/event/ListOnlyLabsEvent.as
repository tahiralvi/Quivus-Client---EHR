package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;

	public class ListOnlyLabsEvent extends CairngormEvent
	{
		public var SearchResults:Boolean,
					clinicBranchID:int, 
					pageNo:int, 
					query:String;
		
		public function ListOnlyLabsEvent(clinicBranchID:int, pageNo:int, searchResults:Boolean, query:String)
		{
			super(ELabsController.LIST_ONLY_LABS, true, false);
			this.SearchResults	= searchResults
			this.query			= query;
			this.clinicBranchID	= clinicBranchID;
			this.pageNo			= pageNo;
		}
	}
}