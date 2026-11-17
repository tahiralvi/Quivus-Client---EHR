package com.gazuntite.provider.live.services.billing.event.settings
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadEDIReceiverByCriteriaEvent extends CairngormEvent
	{		
		public var searchType		:int;
		public var searchString		:String;
		public var pageNo			:int;
		public var callBack			:Function;
		
		public function LoadEDIReceiverByCriteriaEvent(searchType:int, searchString:String, pageNo:int, callBack:Function = null)
		{
			super(BillingController.LOAD_EDI_RECEIVER_BY_CRITERIA_EVENT);
			
			this.searchType   		= searchType;
			this.searchString 	= searchString;
			this.pageNo 		= pageNo;
			this.callBack  		= callBack;
		}
	}
}