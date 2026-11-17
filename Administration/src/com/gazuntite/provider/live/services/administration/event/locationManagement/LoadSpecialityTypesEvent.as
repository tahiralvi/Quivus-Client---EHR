package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadSpecialityTypesEvent extends CairngormEvent
	{
		public function LoadSpecialityTypesEvent()
		{
			super(AdminController.LOAD_SPECIALITY_TYPES_EVENT);
		}
	}
}