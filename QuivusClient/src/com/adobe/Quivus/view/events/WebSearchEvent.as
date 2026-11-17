package com.adobe.Quivus.view.events
{
	import flash.events.Event;
	
	public class WebSearchEvent extends Event
	{
		private var m_sQuery:String;
		
		public function WebSearchEvent(type:String, queryString:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			m_sQuery = queryString;
		}

		public function get Query():String
		{
			return m_sQuery;
		}

	}
}