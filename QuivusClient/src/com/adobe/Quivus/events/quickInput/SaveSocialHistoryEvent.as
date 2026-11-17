package com.adobe.Quivus.events.quickInput
{
	import com.adobe.Quivus.appController.AppController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.SocialHistoryDTO;

	public class SaveSocialHistoryEvent extends CairngormEvent
	{
		public var patientId:int;
		public var branchId:int;
		public var socialHistory:SocialHistoryDTO;
		public var callBack:Function;
		
		public function SaveSocialHistoryEvent(patientId:int,branchId:int,socialHistory:SocialHistoryDTO, callBack:Function = null ) {
			super( AppController.SAVE_SOCIAL_HISTORY_EVENT );
			this.patientId = patientId;
			this.branchId = branchId;
			/*this.medicalHistory = medicalHistory;
			this.familyHistory = familyHistory;*/
			this.socialHistory = socialHistory;
			this.callBack = callBack;
		}
	}
}