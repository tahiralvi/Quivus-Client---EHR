package com.gazuntite.provider.live.services.billing.view.event
{
	import flash.events.Event;
	
	public class RefreshBillingClaimsEvent extends Event
	{
		public function RefreshBillingClaimsEvent(type:String)
		{
			super(type, true);
		}
	}
}