package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class UpdateUserStatusEvent extends CairngormEvent
	{
		public var userId 		: int;
		public var action 		: String;
		public var actionValue 	: String;
		
		public function UpdateUserStatusEvent(userId:int, action:String, actionValue:String )
		{
			super( AdminController.UPDATE_USER_STATUS_EVENT );
			
			this.userId = userId;
			this.action = action;
			this.actionValue = actionValue;
		}
	}
}