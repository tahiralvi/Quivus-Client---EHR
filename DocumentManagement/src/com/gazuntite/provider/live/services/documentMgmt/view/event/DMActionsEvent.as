package com.gazuntite.provider.live.services.documentMgmt.view.event
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	public class DMActionsEvent extends Event
	{
		public static const EMAIL_RECORD_CLICK:String 		= "dataGridEmailRecordClick";
		public static const WRITE_NOTES_CLICK:String 		= "dataGridWriteNotesClick";
		public static const WRITE_DICTATION_CLICK:String 	= "dataGridWriteDictationClick";
		public static const EDIT_RECORD_CLICK:String 		= "dataGridEditRecordClick";
		public static const DELETE_RECORD_CLICK:String 		= "dataGridDeleteRecordClick";
		
		public static const ITEM_EDIT_KEY_UP:String 		= "dataGridItemEditKeyUp";
		
		public var searchString:String;
		public var charCode:uint;
		public var clickPoint:Point;
		public var data:Object;
		
		public function DMActionsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var ev:DMActionsEvent 	= new DMActionsEvent(type, bubbles, cancelable);
			ev.searchString 		= this.searchString;
			ev.charCode 			= this.charCode;
			ev.clickPoint 			= this.clickPoint;
			ev.data 				= this.data;
			
			return ev;
		}
	}
}