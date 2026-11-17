package com.adobe.Quivus.events.viewBackground.lab {

	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.ByteArray;
	
	import valueObjects.LabDTO;

	public class ManagePatientInHouseLabResultsEvent extends CairngormEvent {
		
		
		public var patientInHouseLabTestID:int;
		public var testResult:String;
		public var resultAttachment:ByteArray;

		public function ManagePatientInHouseLabResultsEvent( patientInHouseLabTestID:int,testResult:String,resultAttachment:ByteArray ) {
			super( AppController.MANAGE_PATIENT_IN_HOUSE_LAB_RESULTS_EVENT);
			 this.patientInHouseLabTestID 	= patientInHouseLabTestID;
			 this.testResult 				= testResult;
			 this.resultAttachment 			= resultAttachment;
			
			}
		}
	}