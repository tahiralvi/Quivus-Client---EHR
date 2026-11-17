package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class SavePracticeDetailsEvent extends CairngormEvent
	{
		public var func:Function;
		
		public function SavePracticeDetailsEvent( _func:Function)
		{
			super(AdminController.SAVE_PRACTICE_DETAILS_EVENT);
			this.func    		= _func;
		}
	}
}