package com.adobe.Quivus.events.viewBackground.summary
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadSummaryEvent extends CairngormEvent
	{
		
		public var callBack			: Function;
		
		public function LoadSummaryEvent( callback:Function = null )
		{
			super( AppController.LOAD_VB_SUMMARY_EVENT );
			this.callBack 		= callback;
		}
	}
}