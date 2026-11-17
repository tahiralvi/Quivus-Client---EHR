package com.gazuntite.provider.live.services.billing.view.event
{
	import flash.events.Event;

	public class LoadReportEvent extends Event
	{
		public static const LOAD_REPORT_EVENT:String = "LoadReportEvent";
	
		public function LoadReportEvent()
		{
			super(LOAD_REPORT_EVENT, true, false);
		}		
	}
}