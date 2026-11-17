package com.gazuntite.provider.live.services.administration.event.roleManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class ManageRoleAccessRightEvent extends CairngormEvent
	{
		
		public var userTypeId 		: int;
		public var func 			: Function;
		public function ManageRoleAccessRightEvent(userTypeId : int, func:Function)
		{
			super( AdminController.MANAGE_ROLE_ACCESS_RIGHT_EVENT );
			
			this.userTypeId 		= userTypeId;
			this.func 				= func;
		}
	}
}