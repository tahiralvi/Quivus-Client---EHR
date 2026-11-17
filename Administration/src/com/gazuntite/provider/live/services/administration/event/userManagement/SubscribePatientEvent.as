package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	

	public class SubscribePatientEvent extends CairngormEvent
	{
		public var functionName : Function;
		
		public var purpose		: String;
		public var updateAdd	: String;
	
		public function SubscribePatientEvent(purpose : String, updateAdd:String, functionName : Function)
		{
			super( AdminController.ADMIN_SUBSCRIBE_PATIENT_EVENT);
			this.functionName = functionName;
			this.purpose = purpose;
			this.updateAdd = updateAdd;
		}
	}
}