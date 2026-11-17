package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	
	public class SaveAllRoomsByClinicBranchIDEvent extends CairngormEvent
	{
		
		public var clinicRoomDTOXML:XML;
		public var modifiedBy:int;
		public var func:Function;
		
		public function SaveAllRoomsByClinicBranchIDEvent(_clinicRoomDTOXML:XML, _modifiedBy:int, _func:Function)
		{
			super(AdminController.SAVE_ALL_ROOMS_BY_CLINIC_BRANCH_ID_EVENT);
			
			this.clinicRoomDTOXML 	 	= _clinicRoomDTOXML;
			this.modifiedBy 			= _modifiedBy;
			this.func		   	 		= _func;
		}
	}
}