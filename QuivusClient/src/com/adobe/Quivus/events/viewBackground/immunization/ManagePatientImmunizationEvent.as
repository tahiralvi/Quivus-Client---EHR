package com.adobe.Quivus.events.viewBackground.immunization {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.ImmunizationDTO;
	// for view-background
	public class ManagePatientImmunizationEvent extends CairngormEvent {
		
		//public var immunizationDTOList 		: ArrayCollection;
		

		public function ManagePatientImmunizationEvent( ) {
			super( AppController.MANAGE_PATIENT_IMMUNIZATION_EVENT);
			//this.immunizationDTOList =immunizationDTOList ;
			
			
			}
		}
	}