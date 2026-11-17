package com.adobe.Quivus.events.staticData {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllModuleTypesEvent extends CairngormEvent {
		
		

		public function LoadAllModuleTypesEvent( ) {
			super( AppController.LOAD_ALL_MODULE_TYPES);
			
			}
		}
	}