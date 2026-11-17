package com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadPatientAccountEvent extends CairngormEvent
	{
		
		public var patientId:int;
		public var clinicBranchId:int;
		public var callback:Function;	
		
		public function LoadPatientAccountEvent(patientId:int,clinicBranchId:int,  callback:Function = null )
		{
			super(BillingController.LOAD_PATIENT_ACCOUNT_EVENT);
			
			this.patientId = patientId;
			this.clinicBranchId = clinicBranchId;
			this.callback = callback;
		}
	}
}