package com.adobe.Quivus.view.events
{
	import flash.events.Event;
	
	public class GetBasicInfoEvent extends Event
	{
		public static const GET_BASIC_INFO_EVENT:String = "GetBasicInfoEvent";
		
		public function GetBasicInfoEvent()
		{
			super(GET_BASIC_INFO_EVENT, true, false);
		}
	}
}