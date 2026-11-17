package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class SplitClaimTransactionEvent  extends CairngormEvent
	{
		public var claimTransactionIds:String;
		public var claimId:int;
		public var managedByUserId:int
		public var callBack			: Function;
		
		public function SplitClaimTransactionEvent(claimTransactionIds:String, claimId:int, managedByUserId:int, callback:Function = null )
		{
			super( BillingController.SPLIT_CLAIM_TRANSACTIONS_EVENT );
			
			this.claimTransactionIds = claimTransactionIds;String
			this.claimId = claimId;int
			this.managedByUserId = managedByUserId;int
			this.callBack			= callback;
		}
	}
}