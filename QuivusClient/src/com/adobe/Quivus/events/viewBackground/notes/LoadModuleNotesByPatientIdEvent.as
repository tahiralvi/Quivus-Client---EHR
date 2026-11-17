package com.adobe.Quivus.events.viewBackground.notes {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadModuleNotesByPatientIdEvent extends CairngormEvent {
		
		public function LoadModuleNotesByPatientIdEvent() {
			super( AppController.LOAD_MODULE_NOTES_BY_PATIENT_ID_EVENT);
			}
		}
	}