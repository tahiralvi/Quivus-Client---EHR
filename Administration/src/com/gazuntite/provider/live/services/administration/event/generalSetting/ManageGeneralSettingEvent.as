package com.gazuntite.provider.live.services.administration.event.generalSetting
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class ManageGeneralSettingEvent extends CairngormEvent
	{
		public var func:Function;
		public function ManageGeneralSettingEvent(func:Function)
		{
			super( AdminController.MANAGE_GENERAL_SETTING_EVENT );
			this.func = func;
		}
	}
}