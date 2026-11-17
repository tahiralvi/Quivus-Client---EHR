package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class LoadPracticeDetailsEvent extends CairngormEvent
	{
		public var clinicBranchID:int;
		
		public function LoadPracticeDetailsEvent(_clinicBranchID:int)
		{
			super(AdminController.LOAD_PRACTICE_DETAILS_EVENT);
			
			this.clinicBranchID = _clinicBranchID;
		}
	}
}