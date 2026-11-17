package com.gazuntite.provider.live.services.administration.event.roleManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadRoleAccessRightEvent extends CairngormEvent
	{
		public var userTypeId 		: int;
		
		public function LoadRoleAccessRightEvent(userTypeId 		: int)
		{
			super( AdminController.LOAD_ROLE_ACCESS_RIGHT_EVENT );
			this.userTypeId = userTypeId;
			
		}
	}
}