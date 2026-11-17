package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class LoadPrescriberEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var gaxenId		: String;
	
		public function LoadPrescriberEvent(gaxenId : String,functionName : Function = null)
		{
			super( AdminController.LOAD_PRESCRIBER_EVENT);
			this.functionName = functionName;
			this.gaxenId = gaxenId;
		}
	}
}