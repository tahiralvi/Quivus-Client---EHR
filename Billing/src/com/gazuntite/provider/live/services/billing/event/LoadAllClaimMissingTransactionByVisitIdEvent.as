package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadAllClaimMissingTransactionByVisitIdEvent extends CairngormEvent
	{
		public var visitId			: int;	
		public var claimId			: int;	
		public var managedByUserId	: int;
		public var callBack				: Function
		
		public function LoadAllClaimMissingTransactionByVisitIdEvent(visitId:int,claimId:int,managedByUserId:int, callback:Function = null  )
		{
			super( BillingController.LOAD_ALL_CLAIM_MISSING_TRANSACTION_BY_VISIT_ID_EVENT );	
			
			this.visitId 			= visitId;int
			this.claimId 			= claimId;int
			this.managedByUserId 	= managedByUserId;int
			this.callBack			= callback;
		}
	}
}