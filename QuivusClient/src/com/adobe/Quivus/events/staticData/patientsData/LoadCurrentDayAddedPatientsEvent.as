package com.adobe.Quivus.events.staticData.patientsData
{
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadCurrentDayAddedPatientsEvent extends CairngormEvent {
		
		public var pageNo :int;
		public var func:Function;
		
		public function LoadCurrentDayAddedPatientsEvent(_pageNo:int, _func:Function = null) 
		{
			super( AppController.LOAD_CURRENT_DAY_ADDED_PATIENTS_EVENT);
			
			this.pageNo 			= _pageNo;
			this.func 		= _func;
		}
	}
}