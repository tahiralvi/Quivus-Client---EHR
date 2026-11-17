package com.adobe.Quivus.view.events
{
	import flash.events.Event;
	
	import valueObjects.PatientSearchDTO;
	
	public class PatientSelectedEvent extends Event
	{
		public var selection:Object;
		
		public function PatientSelectedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}