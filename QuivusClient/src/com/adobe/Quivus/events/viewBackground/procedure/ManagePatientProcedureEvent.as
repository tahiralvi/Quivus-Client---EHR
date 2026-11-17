package com.adobe.Quivus.events.viewBackground.procedure {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class ManagePatientProcedureEvent extends CairngormEvent {
		
		//public var inputList:ArrayCollection;
		

		public function ManagePatientProcedureEvent(  ) {
			super( AppController.MANAGE_PATIENT_PROCEDURE_EVENT);
			// this.inputList = inputList;
			
			}
		}
	}