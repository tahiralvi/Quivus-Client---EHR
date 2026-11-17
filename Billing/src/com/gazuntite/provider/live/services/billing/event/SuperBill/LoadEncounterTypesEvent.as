package com.gazuntite.provider.live.services.billing.event.SuperBill
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class LoadEncounterTypesEvent extends CairngormEvent
	{
		public function LoadEncounterTypesEvent()
		{
			super( BillingController.LOAD_ENCOUNTER_TYPES_EVENT);
		}
	}
}