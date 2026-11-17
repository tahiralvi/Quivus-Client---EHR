package com.gazuntite.provider.live.services.billing.event.SuperBill
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadICDCodeTypesEvent extends CairngormEvent
	{
		public var ICDCodeName:String	;
		public var clinicBranchID:String	;
		public var func:Function;
		
		public function LoadICDCodeTypesEvent(ICDCodeName:String,clinicBranchID:String,_func:Function = null)
		{
			super(BillingController.LOAD_ICD_CODE_TYPES_EVENT)
			this.ICDCodeName = ICDCodeName;
			this.clinicBranchID = clinicBranchID;
			this.func 		= _func;
		}
	}
} 