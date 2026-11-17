package com.gazuntite.provider.live.services.billing.event.ClaimManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ClaimPatientSearchEvent extends CairngormEvent
	{		
		public var clinicBranchId		    : int;
		public var callBack			    : Function;
		
		public function ClaimPatientSearchEvent(clinicBranchId: int, callBack: Function = null)
		{
			super(BillingController.CLAIM_PATIENT_SEARCH_EVENT);
			
			this.clinicBranchId = clinicBranchId;
			this.callBack       = callBack;
		}
	}
}