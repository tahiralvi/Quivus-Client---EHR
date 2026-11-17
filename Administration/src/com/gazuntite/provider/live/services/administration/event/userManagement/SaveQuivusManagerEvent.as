package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class SaveQuivusManagerEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var purpose		: String;
	
		public function SaveQuivusManagerEvent(purpose : String, functionName : Function)
		{
			super( AdminController.SAVE_QUIVUS_MANAGER_EVENT);
			this.functionName = functionName;
			this.purpose = purpose;
		}
	}
}