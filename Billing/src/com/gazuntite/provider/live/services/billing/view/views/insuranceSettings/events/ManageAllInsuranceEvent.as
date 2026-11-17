package com.gazuntite.provider.live.services.billing.view.views.insuranceSettings.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	
	public class ManageAllInsuranceEvent extends CairngormEvent
	{
		public var xmlData:XML;
		public var callBack:Function;
		public function ManageAllInsuranceEvent(xmlData:XML,callBack:Function)
		{
			super(BillingController.MANAGE_ALL_INSURANCE_EVENT);
			this.xmlData 	= xmlData ;
			this.callBack 	= callBack ;
		}
	}
}