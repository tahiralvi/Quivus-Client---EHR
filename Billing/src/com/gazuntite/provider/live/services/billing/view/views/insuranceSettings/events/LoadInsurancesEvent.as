package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	
	public class LoadInsurancesEvent extends CairngormEvent
	{
		public var callBackFunction:Function;
		public var pageNumber:int ;
		
		public function LoadInsurancesEvent(pageNumber:int,callBackFunction:Function)
		{
			super(BillingController.LOAD_INSURANCE_EVENT);
			this.pageNumber			= pageNumber ;
			this.callBackFunction   = callBackFunction;
		}
	}
}