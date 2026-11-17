package com.gazuntite.provider.live.services.administration.event.accessRightManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class ManageUserAccessRightEvent extends CairngormEvent
	{
		public var userId 		: int;
		public var branchId 		: int;
		public var func 		: Function;
		
		
		public function ManageUserAccessRightEvent(userId:int, branchId:int, _func:Function)
		{
			super( AdminController.MANAGE_USER_ACCESS_RIGHT_EVENT);
			
			this.userId = userId;
			this.branchId = branchId;
			this.func     = _func;
		}
	}
}