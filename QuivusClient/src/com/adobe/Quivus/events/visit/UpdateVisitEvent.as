package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class UpdateVisitEvent extends CairngormEvent {
		
		
		

		public function UpdateVisitEvent( ) {
			super( AppController.UPDATE_VISIT_EVENT);
			 
			
			}
		}
	}