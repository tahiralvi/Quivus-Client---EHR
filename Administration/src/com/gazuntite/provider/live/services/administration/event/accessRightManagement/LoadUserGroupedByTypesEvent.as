package com.gazuntite.provider.live.services.administration.event.accessRightManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadUserGroupedByTypesEvent extends CairngormEvent
	{
		public function LoadUserGroupedByTypesEvent()
		{
			super( AdminController.LOAD_USER_GROUPED_BY_TYPES_EVENT );
		}
	}
}