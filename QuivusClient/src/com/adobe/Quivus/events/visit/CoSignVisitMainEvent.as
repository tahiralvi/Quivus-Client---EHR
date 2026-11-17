package com.adobe.Quivus.events.visit {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CoSignVisitMainEvent extends CairngormEvent {
		
		public var visitId : int;
		
		public var functionName 	: Function;

		public function CoSignVisitMainEvent(visitId : int,functionName 	: Function) 
		{
			super( AppController.CO_SIGN_VISIT_MAIN_EVENT);
			this.visitId = visitId;
			this.functionName = functionName;
			
			}
		}
	}