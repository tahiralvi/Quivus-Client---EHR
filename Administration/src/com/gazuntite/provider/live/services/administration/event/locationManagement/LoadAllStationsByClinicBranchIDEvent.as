package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	
	public class LoadAllStationsByClinicBranchIDEvent extends CairngormEvent
	{
		public var clinicBranchID:int;
		public function LoadAllStationsByClinicBranchIDEvent(_clinicBranchID:int)
		{
			super(AdminController.LOAD_ALL_STATIONS_BY_CLINIC_BRANCH_ID_EVENT);
			
			this.clinicBranchID = _clinicBranchID;
		}
	}
}