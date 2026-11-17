package com.gazuntite.provider.live.services.billing.event.report
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ERAReportSetupEvent extends CairngormEvent
	{
		//public var searchType:int;
		public var searchXML:XML;
		public var callback:Function = null ;
		
		//public function ERAReportSetupEvent(searchType:int, searchXML:XML, callback:Function = null )
		public function ERAReportSetupEvent(searchXML:XML, callback:Function = null )
		{
			super(BillingController.ERA_REPORT_SETUP_EVENT);
			
			//this.searchType = searchType;
			this.searchXML = searchXML;
			this.callback = callback;
		}
	}
}