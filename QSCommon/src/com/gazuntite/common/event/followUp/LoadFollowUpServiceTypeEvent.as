package com.gazuntite.common.event.followUp
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadFollowUpServiceTypeEvent extends CairngormEvent
	{
		public var followupDataControlTypeID:int;
		public var searchTerm:String;
		public var model:Object;
		
		public function LoadFollowUpServiceTypeEvent(followupDataControlTypeID:int, searchTerm:String, model:Object)
		{
			super (QSCommonController.LOAD_SERVICE_TYPE_EVENT);
			
			this.followupDataControlTypeID = followupDataControlTypeID;
			this.searchTerm = searchTerm;
			this.model = model;
		}
	}
}