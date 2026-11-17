package com.adobe.Quivus.events.search.searchEngine
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadUserSearchEngineEvent extends CairngormEvent 
	{
	
		public static var isAlreadyLoaded:Boolean= false;
		
		public function LoadUserSearchEngineEvent(  ) {
			super( AppController.LOAD_USER_SEARCH_ENGINE_EVENT);
			
		}
	}
	
}