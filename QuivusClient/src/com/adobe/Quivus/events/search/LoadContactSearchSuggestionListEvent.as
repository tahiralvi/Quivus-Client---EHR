package com.adobe.Quivus.events.search {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadContactSearchSuggestionListEvent extends CairngormEvent {
		
		

		public function LoadContactSearchSuggestionListEvent(  ) {
			super( AppController.LOAD_CONTACT_SEARCH_SUGGESTION_LIST_EVENT);
			
			}
		}
	}