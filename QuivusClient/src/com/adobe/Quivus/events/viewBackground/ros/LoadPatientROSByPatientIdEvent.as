package com.adobe.Quivus.events.viewBackground.ros {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadPatientROSByPatientIdEvent extends CairngormEvent {
		
		
		

		public function LoadPatientROSByPatientIdEvent( ) {
			super( AppController.LOAD_PATIENT_ROS_BY_PATIENT_ID_EVENT);
			 
			
			}
		}
	}