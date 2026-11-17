package com.adobe.Quivus.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.Quivus.appController.AppController;

	public class LoadUserMostRecentPatientEvent extends CairngormEvent {
		
		
		public static var isAlreadyLoaded:Boolean= false;

		public function LoadUserMostRecentPatientEvent(  ) {
			super( AppController.LOAD_USER_MOST_RECENT_PATIENT_EVENT);
			
			}
		}
	}