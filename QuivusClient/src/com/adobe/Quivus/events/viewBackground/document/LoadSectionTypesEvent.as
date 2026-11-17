package com.adobe.Quivus.events.viewBackground.document
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoadSectionTypesEvent extends CairngormEvent
	{
		public function LoadSectionTypesEvent()
		{
			super( AppController.LOAD_SECTION_TYPES_EVENT);
		}
	}
}