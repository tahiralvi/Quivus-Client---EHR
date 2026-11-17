package com.gazuntite.provider.live.services.billing.event.SuperBill
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadStateCodesEvent extends CairngormEvent
	{
		public function LoadStateCodesEvent()
		{
			super( BillingController.LOAD_STATE_CODE_EVENT);
		}
	}
}