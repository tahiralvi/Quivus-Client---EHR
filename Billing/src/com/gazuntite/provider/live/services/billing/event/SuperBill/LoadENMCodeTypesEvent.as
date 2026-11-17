package com.gazuntite.provider.live.services.billing.event.SuperBill
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadENMCodeTypesEvent extends CairngormEvent
	{
		public function LoadENMCodeTypesEvent()
		{
			super( BillingController.LOAD_ENM_CODE_TYPES_EVENT);
		}
	}
}