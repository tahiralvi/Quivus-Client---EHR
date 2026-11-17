package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;

	public class SaveAddressEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var purpose		: String;
	
		public function SaveAddressEvent(purpose : String, functionName : Function)
		{
			super( AdminController.SAVE_ADDRESS_EVENT);
			this.functionName = functionName;
			this.purpose = purpose;
		}
	}
}