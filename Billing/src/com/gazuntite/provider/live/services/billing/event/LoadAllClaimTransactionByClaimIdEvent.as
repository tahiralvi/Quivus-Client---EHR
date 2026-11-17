package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	
	public class LoadAllClaimTransactionByClaimIdEvent extends CairngormEvent
	{
		
		public var claimId			: int;
		public var callBack			: Function;
		
		public function LoadAllClaimTransactionByClaimIdEvent( claimId:int, callback:Function = null)
		{
			super( BillingController.LOAD_ALL_CLAIM_TRANSACTION_BY_CLAIM_ID_EVENT );	
			
			this.claimId 		= claimId;int
			this.callBack 		    = callback;			
		}
	}
}