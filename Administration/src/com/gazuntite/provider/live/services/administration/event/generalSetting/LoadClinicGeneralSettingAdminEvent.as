package com.gazuntite.provider.live.services.administration.event.generalSetting
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadClinicGeneralSettingAdminEvent extends CairngormEvent
	{
		public function LoadClinicGeneralSettingAdminEvent()
		{
			super( AdminController.LOAD_CLINIC_GENERAL_SETTING_ADMIN_EVENT );
		}
	}
}