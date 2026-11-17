package com.adobe.Quivus.events.communication.videochat
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class VideoCallAcceptCallEvent extends CairngormEvent
	{
		public static const ACCEPT_VIDEO_CALL_EVENT:String = "AcceptVideoCallEvent";
		public var videoChatID 	: int;
		/*public var callBack			: Function;*/
		
		public function VideoCallAcceptCallEvent(videoChatID:int)
		{
			//super(ACCEPT_VIDEO_CALL_EVENT, true, false);
			super(AppController.ACCEPT_VIDEO_CALL_NOTIFICATION);
			this.videoChatID = videoChatID;
			/*this.callBack 		= callback;*/
		}
		
	
	}
}