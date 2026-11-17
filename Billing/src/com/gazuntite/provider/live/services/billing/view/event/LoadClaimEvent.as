package com.gazuntite.provider.live.services.billing.view.event
{
	import flash.events.Event;
	
	public class LoadClaimEvent extends Event
	{
		public function LoadClaimEvent(type:String)
		{
			super(type, true);
		}
	}
}