package com.adobe.Quivus.view.events
{import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.sampler.NewObjectSample;

import valueObjects.ContactSearchDTO;
	public class smsClickEvent extends MouseEvent
	{
		
		public  static const NAME:String = "smsClick";
		private var contactDTO:ContactSearchDTO;
		
		public function smsClickEvent(type:String, contact:ContactSearchDTO, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=NaN, localY:Number=NaN, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0, commandKey:Boolean=false, controlKey:Boolean=false, clickCount:int=0)
		{
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
			contactDTO = contact;
		}
		
		public function get ContactDTO():ContactSearchDTO
		{
			return contactDTO;
		}
		
		override public function clone():Event
		{
			var e:smsClickEvent = new smsClickEvent(type,contactDTO, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
			
			return e;
		}

	}
}