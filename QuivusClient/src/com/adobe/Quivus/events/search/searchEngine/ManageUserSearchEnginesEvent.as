package com.adobe.Quivus.events.search.searchEngine {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class ManageUserSearchEnginesEvent extends CairngormEvent {
		
		public var searchEnginesIdsList:ArrayCollection;
		

		public function ManageUserSearchEnginesEvent( searchEnginesIdsList:ArrayCollection ) {
			super( AppController.MANAGE_USER_SEARCH_ENGINES_EVENT);
			this.searchEnginesIdsList = searchEnginesIdsList;
			
			}
		}
	}