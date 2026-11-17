package com.gazuntite.patient.visit.event.summary
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadSummaryEvent extends CairngormEvent
	{
		
		public var callBack			: Function;
		
		public function LoadSummaryEvent( callback:Function = null )
		{
			super (VBController.LOAD_VB_SUMMARY_EVENT );
			this.callBack = callback;
		}
	}
}