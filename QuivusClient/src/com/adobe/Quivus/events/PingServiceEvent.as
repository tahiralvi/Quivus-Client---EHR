package com.adobe.Quivus.events
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class PingServiceEvent extends CairngormEvent
	{
		public function PingServiceEvent()
		{
			super(AppController.PING_SERVICE_EVENT, true, false);
		}
	}
}