package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class RemoveClaimTransactionEvent extends CairngormEvent
	{
		public var claimTransactionIds:String;		
		public var managedByUserId:int
		public var callBack			: Function;
		
		public function RemoveClaimTransactionEvent(claimTransactionIds:String, managedByUserId:int, callback:Function = null )
		{
			super( BillingController.REMOVE_CLAIM_TRANSACTIONS_EVENT );
			
			this.claimTransactionIds = claimTransactionIds;String			
			this.managedByUserId = managedByUserId;int
			this.callBack			= callback;
		}
	}
}