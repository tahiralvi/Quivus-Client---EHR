package com.gazuntite.provider.live.services.billing.event.SuperBill
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadFrequencyCodeTypesEvent extends CairngormEvent
	{
		public function LoadFrequencyCodeTypesEvent()
		{
			super( BillingController.LOAD_FREQUENCY_CODE_TYPES_EVENT);
		}
	}
}