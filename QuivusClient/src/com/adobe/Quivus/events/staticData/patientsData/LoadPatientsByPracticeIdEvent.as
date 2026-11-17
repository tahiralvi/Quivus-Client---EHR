package com.adobe.Quivus.events.staticData.patientsData
{
	
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadPatientsByPracticeIdEvent extends CairngormEvent 
	{
		
		public var clinicBranchID :int;
		public var pageNo :int;
		public var lastSynTime :String;
		public var isLoadAll :Boolean;
		public var func:Function;
		
		public function LoadPatientsByPracticeIdEvent( _pageNo:int, _lastSynTime:String, _isLoadAll:Boolean, _func:Function = null) 
		{
			super( AppController.LOAD_PATIENTS_BY_PRACTICE_ID_EVENT);
			
			this.pageNo 			= _pageNo;
			this.lastSynTime 		= _lastSynTime;
			this.isLoadAll	 		= _isLoadAll;
			this.func 		= _func;
		}
	}
}