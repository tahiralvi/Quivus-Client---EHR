package com.adobe.Quivus.events.quickInput
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import valueObjects.SocialHistoryDTO;

	public class SaveMedicalHistoryEvent extends CairngormEvent
	{
		public var patientId:int;
		public var branchId:int;
		public var medicalHistory:Object;
		public var callBack:Function;
		
		public function SaveMedicalHistoryEvent(patientId:int,branchId:int, medicalHistory:Object, callBack:Function = null ) 
		{
			super( AppController.SAVE_MEDICAL_HISTORY_EVENT );
			this.patientId = patientId;
			this.branchId = branchId;
			this.medicalHistory = medicalHistory;
			
			this.callBack = callBack;
		}
	}
}