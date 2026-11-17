package com.gazuntite.provider.live.services.administration.event.roleManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadRoleEvent extends CairngormEvent
	{
		public function LoadRoleEvent()
		{
			super( AdminController.LOAD_USER_ROLES_EVENT );
		}
	}
}