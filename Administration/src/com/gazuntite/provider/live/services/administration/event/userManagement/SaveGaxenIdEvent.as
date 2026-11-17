package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class SaveGaxenIdEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var userId		: String;
		public var gaxenId		: String;
	
		public function SaveGaxenIdEvent(userId : String, gaxenId:String, functionName : Function = null)
		{
			super( AdminController.SAVE_GAXEN_ID_EVENT);
			this.functionName = functionName;
			this.userId = userId;
			this.gaxenId = gaxenId;
		}
	}
}