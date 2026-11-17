package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.LabDTO;
	import valueObjects.RegistrationDTO;

	public class ManagePatientLabsEvent extends CairngormEvent {
		
		//public var labDTO:LabDTO;
		

		public function ManagePatientLabsEvent(  ) {
			super( AppController.MANAGE_PATIENT_LABS_EVENT);
			 //this.labDTO = labDTO;
			
			}
		}
	}