package com.adobe.Quivus.events.viewBackground.notes {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class ManageModuleNotesEvent extends CairngormEvent {
		
				
		public function ManageModuleNotesEvent( ) {
			super( AppController.MANAGE_MODULE_NOTES_EVENT);
			
			}
		}
	}