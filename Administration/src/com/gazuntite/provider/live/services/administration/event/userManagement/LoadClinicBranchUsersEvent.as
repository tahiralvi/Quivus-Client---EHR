package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadClinicBranchUsersEvent extends CairngormEvent
	{
		public function LoadClinicBranchUsersEvent()
		{
			super( AdminController.LOAD_CLINIC_BRANCH_USERS_EVENT );
		}
	}
}