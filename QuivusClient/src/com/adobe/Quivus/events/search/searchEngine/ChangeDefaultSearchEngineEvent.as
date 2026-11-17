package com.adobe.Quivus.events.search.searchEngine {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ChangeDefaultSearchEngineEvent extends CairngormEvent {
		
		public var userId : int;
		public var clinicBranchId : int;
		public var searchEngineId : int;

		public function ChangeDefaultSearchEngineEvent( userId : int, clinicBranchId : int ,searchEngineId : int) {
			super( AppController.SET_DEFAULT_SEARCH_ENGINE_EVENT);
			this.userId = userId;
			this.clinicBranchId = clinicBranchId;
			this.searchEngineId = searchEngineId;
			}
		}
	}