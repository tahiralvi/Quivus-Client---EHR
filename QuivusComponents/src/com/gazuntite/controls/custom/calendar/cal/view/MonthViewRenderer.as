package com.gazuntite.controls.custom.calendar.cal.view
{
	import com.gazuntite.controls.custom.calendar.cal.event.CalendarEvent;
	import com.gazuntite.controls.custom.calendar.cal.event.CompactEventRenderer;
	
	import mx.collections.ArrayCollection;
	
	public class MonthViewRenderer extends ViewRenderer
	{
		internal override function updateEventRenderer(event:CalendarEvent): void 
		{
			event.rendererFactory = CompactEventRenderer;
		}
		
		internal override function layoutEvents(events:ArrayCollection, width:Number, height:Number):void 
		{
			var lastY:Number = 0;
			for each (var event:CalendarEvent in events) 
			{
				updateEventRenderer(event);
				event.x = 0;
				event.y = lastY;
				event.width = width;
				event.height = event.getExplicitOrMeasuredHeight();
				lastY += event.height;
			}
		}
	}
}