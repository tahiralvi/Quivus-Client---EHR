package com.adobe.Quivus.events.communication.videochat
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class VideoCallNotificationEvent extends CairngormEvent
	{
		public static const ACCEPT_VIDEO_CALL_EVENT:String = "VideoCallNotificationEvent";
		public var videoChatID 	: int;
		public var callBack			: Function;
		
		public function VideoCallNotificationEvent(videoChatID:int,callback:Function)
		{
			super(AppController.OUTGOING_VIDEO_CALL_NOTIFICATION);
			this.videoChatID = videoChatID;
			this.callBack 		= callback;
		}
	
	}
}