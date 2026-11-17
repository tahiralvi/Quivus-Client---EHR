package com.adobe.Quivus.events.viewBackground.ros {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class ManagePatientROSEvent extends CairngormEvent {
		
		
		

		public function ManagePatientROSEvent( ) {
			super( AppController.MANAGE_PATIENT_ROS_EVENT);
			 
			
			}
		}
	}