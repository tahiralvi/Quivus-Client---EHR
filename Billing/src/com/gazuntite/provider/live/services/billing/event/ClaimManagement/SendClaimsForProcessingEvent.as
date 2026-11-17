package com.gazuntite.provider.live.services.billing.event.ClaimManagement
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class SendClaimsForProcessingEvent extends CairngormEvent
	{
		public var EDIReceiverID		    : int;
		public var insuranceTypeId		    : int;
		public var clinicBranchId		    : int;
		public var processedByUserID		: int;
		public var callBack			    : Function;
		
		public function SendClaimsForProcessingEvent(EDIReceiverID:int, insuranceTypeId:int, clinicBranchId:int, processedByUserID:int, callBack: Function = null )
		{
			super(BillingController.SEND_CLAIMS_FOR_PROCESSING);
			
			this.EDIReceiverID  	= EDIReceiverID;
			this.insuranceTypeId  	= insuranceTypeId;
			this.clinicBranchId  	= clinicBranchId;
			this.processedByUserID  = processedByUserID;
			this.callBack  			= callBack;
		}
	}
}