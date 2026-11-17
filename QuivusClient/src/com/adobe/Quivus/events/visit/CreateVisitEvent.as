package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class CreateVisitEvent extends CairngormEvent {
		
		
		

		public function CreateVisitEvent( ) {
			super( AppController.CREATE_VISIT_EVENT);
			 
			
			}
		}
	}