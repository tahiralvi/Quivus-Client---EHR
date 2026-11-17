package com.gazuntite.provider.live.services.elab.view.event
{
	import flash.events.Event;
	
	public class ElabActionEvent extends Event
	{
		public static const VIEW_DOCUMENT:String 		= "dataGridViewDocumentClick";
		public static const EDIT_RECORD_CLICK:String 	= "dataGridEditRecordClick";
		public static const SAVE_RECORD_CLICK:String 	= "dataGridSaveRecordClick";
		public static const RESULT_CLICK:String 		= "dataGridResultClick";
		
		public static const VIEW_RESULT_CLICK:String 		= "dataGridViewResultClick";
		public static const ENTER_RESULT_CLICK:String 		= "dataGridEnterResultClick";
		public static const VIEW_ATTACHMENT_CLICK:String 	= "dataGridViewAttachmentClick";
		
		public var selection:Object;
		
		public function ElabActionEvent(type:String)
		{
			super(type, true, false);
		}
	}
}