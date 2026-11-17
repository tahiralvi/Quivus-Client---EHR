package com.gazuntite.provider.live.services.waitingRoom.view.event
{
	import flash.events.Event;
	
	public class LoadAppEvent extends Event
	{
		public function LoadAppEvent(type:String)
		{
			super(type, true);
		}
	}
}