package com.adobe.Quivus.events.visit {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.RegistrationDTO;
	import com.adobe.Quivus.appController.AppController;

	public class LoadVisitStakeHoldersByVisitIdEvent extends CairngormEvent {
		
		public var visitId : int;
		
		

		public function LoadVisitStakeHoldersByVisitIdEvent(visitId : int) {
			super( AppController.LOAD_VISIT_STAKEHOLDERS_BY_VISITID_EVENT);
			this.visitId = visitId;
			 
			
			}
		}
	}