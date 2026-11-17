package com.adobe.Quivus.events.quickInput {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RegistrationDTO;

	
	public class LoadQuickInputByVisitIdEvent extends CairngormEvent {
		
		public var visitId:int;

		public function LoadQuickInputByVisitIdEvent(visitId:int ) {
			super( AppController.LOAD_QUICK_INPUT_BY_VISIT_ID_EVENT);
			 this.visitId = visitId;
			}
		}
	}