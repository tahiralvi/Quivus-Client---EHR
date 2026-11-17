package com.adobe.Quivus.events.quickInput
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.SocialHistoryDTO;

	public class SaveFamilyHistoryEvent extends CairngormEvent
	{
		public var patientId:int;
		public var branchId:int;
		public var  familyHistory:ArrayCollection;
		public var callBack:Function;
		
		public function SaveFamilyHistoryEvent(patientId:int,branchId:int, 
												familyHistory:ArrayCollection, callBack:Function = null ) {
			super( AppController.SAVE_FAMILY_HISTORY_EVENT );
			this.patientId = patientId;
			this.branchId = branchId;
			//this.medicalHistory = medicalHistory;
			this.familyHistory = familyHistory;
			//this.socialHistory = socialHistory
			this.callBack = callBack;
		}
	}
}