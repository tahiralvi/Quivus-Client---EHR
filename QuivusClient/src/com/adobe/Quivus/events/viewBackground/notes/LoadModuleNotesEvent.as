package com.adobe.Quivus.events.viewBackground.notes {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadModuleNotesEvent extends CairngormEvent {
		
		public var visitId 		: int;
		
		public function LoadModuleNotesEvent(visitId 		: int) {
			super( AppController.LOAD_MODULE_NOTES_EVENT);
			this.visitId = visitId;
			
			}
		}
	}