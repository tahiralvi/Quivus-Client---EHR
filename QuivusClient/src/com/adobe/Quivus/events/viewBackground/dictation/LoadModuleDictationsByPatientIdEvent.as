package com.adobe.Quivus.events.viewBackground.dictation {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;

	public class LoadModuleDictationsByPatientIdEvent extends CairngormEvent {
		
		public function LoadModuleDictationsByPatientIdEvent() {
			super( AppController.LOAD_MODULE_DICTATIONS_BY_PATIENT_ID_EVENT);
			}
		}
	}