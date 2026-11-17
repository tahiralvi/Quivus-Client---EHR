package com.gazuntite.provider.live.services.administration.event.userManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadAllUserTypeEvent extends CairngormEvent
	{
		
		public function LoadAllUserTypeEvent()
		{
			super(AdminController.LOAD_ALL_USER_TYPE_EVENT);
		}
	}
}