package com.gazuntite.provider.live.services.administration.event
{
	import flash.events.Event;
	
	public class AdminActionsEvent extends Event
	{
		
		public static const EDIT_RECORD_CLICK:String 		= "dataGridEditRecordClick";
		public static const UPDATE_ACCESS_RIGHTS:String 	= "updateAccessRights";
		public static const GENERAL_SETTING_UPDATE:String 	= "generalSettingUpdate";
		
		
		
		public function AdminActionsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var ev:AdminActionsEvent = new AdminActionsEvent(type, bubbles, cancelable);
			
			return ev;
		}
		
	}
}