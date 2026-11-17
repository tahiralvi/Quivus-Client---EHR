package com.adobe.Quivus.view.events
{
	import com.adobe.Quivus.utils.AppEventStrings;
	
	import flash.events.Event;
	
	public class ComingSoonEvent extends Event
	{
		public var HeaderLabel:String
		public function ComingSoonEvent(headerLabel:String)
		{
			super(AppEventStrings.SHOW_COMING_SOON_EVENT, bubbles, cancelable);
			HeaderLabel = headerLabel;
		}
	}
}