package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class ImportVisitByPatientIdEvent extends CairngormEvent {
		
		public var templateId : int;
		
		

		public function ImportVisitByPatientIdEvent(templateId : int) {
			super( AppController.IMPORT_VISIT_BY_PATIENTID_EVENT);
			this.templateId = templateId;			
			}
		}
	}