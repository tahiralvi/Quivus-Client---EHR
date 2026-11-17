package com.adobe.Quivus.events.quickInput
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	public class DeleteComprehensiveModuleDatabyPatientIDEvent  extends CairngormEvent
	{
		public var patientId:int;
		public var branchId:int;
		public var typeID:int;
		public var CH_Section:int;
		public var ch_data:ArrayCollection;
		public var callBack:Function;
		
		public function DeleteComprehensiveModuleDatabyPatientIDEvent(ch_data:ArrayCollection, PatientID:int, CH_Section:int, 
																		typeID:int, clinicBranchID:int, callBack:Function = null)
		{
			super( AppController.DELETE_COMPREHENSIVE_MODULE_DATA_EVENT);
			this.ch_data	= ch_data;
			this.patientId 	= PatientID;
			this.CH_Section = CH_Section;
			this.typeID 	= typeID;
			this.branchId 	= clinicBranchID;
			this.callBack 	= callBack;
		}
	}
}