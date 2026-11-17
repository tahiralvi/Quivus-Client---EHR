package com.adobe.Quivus.events.viewBackground.procedure {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class LoadPatientProcedureByPatientIdEvent extends CairngormEvent {
		
		

		public function LoadPatientProcedureByPatientIdEvent(  ) {
			super( AppController.LOAD_PATIENT_PROCEDURE_BY_PATIENT_ID_EVENT);
			 
			
			}
		}
	}