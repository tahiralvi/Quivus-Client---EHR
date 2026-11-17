package com.gazuntite.provider.live.services.billing.view.event
{	
	import flash.events.Event;
	
	public class LoadReportPanelEvent extends Event
	{
		public static const LOAD_REPORT_PANEL_EVENT:String = "LoadReportPanelEvent";
		
		public function LoadReportPanelEvent()
		{
			super(LOAD_REPORT_PANEL_EVENT, true, false);
		}
	}
}