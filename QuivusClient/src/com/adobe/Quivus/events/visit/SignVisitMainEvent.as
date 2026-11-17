package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class SignVisitMainEvent extends CairngormEvent {
		
		public var visitId : int;
		
		public var functionName 	: Function;

		public function SignVisitMainEvent(visitId : int,functionName 	: Function) {
			super( AppController.SIGN_VISIT_MAIN_EVENT);
			this.visitId = visitId;
			 this.functionName = functionName;
			
			}
		}
	}