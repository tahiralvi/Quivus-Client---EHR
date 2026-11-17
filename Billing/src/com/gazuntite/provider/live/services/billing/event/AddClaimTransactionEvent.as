package com.gazuntite.provider.live.services.billing.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class AddClaimTransactionEvent extends CairngormEvent
	{
		public var transactionXml:XML;			
		public var managedByUserId:int
		public var callBack:Function;
		
		public function AddClaimTransactionEvent(transactionXml:XML,managedByUserId:int,callBack:Function = null )
		{
			super( BillingController.ADD_CLAIM_TRANSACTIONS_EVENT );
			
			this.transactionXml  = transactionXml;XML			
			this.managedByUserId = managedByUserId;int
			this.callBack        = callBack
		} 
	}
}