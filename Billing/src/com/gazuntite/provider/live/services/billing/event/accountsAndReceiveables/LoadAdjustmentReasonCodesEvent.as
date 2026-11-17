package com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadAdjustmentReasonCodesEvent extends CairngormEvent
	{
		public var callback:Function;
		
		public function LoadAdjustmentReasonCodesEvent(callback:Function = null )
		{
			super(BillingController.LOAD_ADJUSTMENT_REASON_CODES_EVENT);			
			
			this.callback = callback;
		}
	}
}