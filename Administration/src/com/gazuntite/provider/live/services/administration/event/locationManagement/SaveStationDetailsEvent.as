package com.gazuntite.provider.live.services.administration.event.locationManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.administration.appController.AdminController;
	import com.gazuntite.provider.live.services.administration.dto.locationManagement.AdminStationDTO;
	
	public class SaveStationDetailsEvent extends CairngormEvent
	{
		public var adminStationXML:XML;
		public var modifiedByID:int;
		public var func:Function;
		
		public function SaveStationDetailsEvent(_adminStationXML:XML ,_modifiedByID:int, _func:Function)
		{
			super(AdminController.SAVE_STATION_DETAILS_EVENT);
			
			this.adminStationXML= _adminStationXML;
			this.modifiedByID 	= _modifiedByID;
			this.func 			= _func;
		}
	}
}