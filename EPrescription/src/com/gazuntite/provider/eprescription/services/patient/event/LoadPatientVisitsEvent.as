package com.gazuntite.provider.eprescription.services.patient.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.appController.EPrescriptionController;
	
	public class LoadPatientVisitsEvent extends CairngormEvent
	{
		
		public var resultHandlerFunction:Function;
		public var userId:String;
		public var clinicBranchId:String;
		
	
		public function LoadPatientVisitsEvent(userId:String, clinicBranchId:String, resultHandlerFunction:Function)
		{
			super(EPrescriptionController.LOAD_PATIENT_VISIT);
			this.resultHandlerFunction = resultHandlerFunction;
			
			this.userId 	= userId;
		
			this.clinicBranchId 	= clinicBranchId;
			
		}
	}
}