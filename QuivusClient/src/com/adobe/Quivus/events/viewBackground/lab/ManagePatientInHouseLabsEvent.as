package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class ManagePatientInHouseLabsEvent extends CairngormEvent {
		
		//public var inputList:ArrayCollection;
		

		public function ManagePatientInHouseLabsEvent(  ) {
			super( AppController.MANAGE_PATIENT_IN_HOUSE_LABS_EVENT);
			// this.inputList = inputList;
			
			}
		}
	}