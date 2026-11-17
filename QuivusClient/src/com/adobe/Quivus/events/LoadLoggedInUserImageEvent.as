package com.adobe.Quivus.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.PatientAllergyDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadLoggedInUserImageEvent extends CairngormEvent {
		
		

		public function LoadLoggedInUserImageEvent(  ) {
			super( AppController.LOAD_LOGGED_IN_USER_IMAGE_EVENT);
			
			}
		}
	}