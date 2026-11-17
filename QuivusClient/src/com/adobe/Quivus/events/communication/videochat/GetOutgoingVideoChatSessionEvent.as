package com.adobe.Quivus.events.communication.videochat
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetOutgoingVideoChatSessionEvent extends CairngormEvent
	{
		
			public var userId : int;
			public var branchId : int;
			public var resultHandlerFunction:Function;
			
			public function GetOutgoingVideoChatSessionEvent(userId : int,resultHandlerFunction:Function)
			{
				super(AppController.GET_INCOMING_VIDEO_CHAT_SESSION);
				this.userId = userId;
				this.resultHandlerFunction = resultHandlerFunction;
			}
	}
}