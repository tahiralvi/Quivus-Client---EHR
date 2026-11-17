package com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ManageClaimPaymentEvent extends CairngormEvent
	{
		public var xmlDocument		:XML;
		public var callBack			:Function;
		
		public function ManageClaimPaymentEvent(xmlDocument:XML, callBack:Function = null)
		{
			super(BillingController.MANAGE_CLAIM_PAYMENT_EVENT);
			
			this.xmlDocument     =  xmlDocument;
			this.callBack		 =  callBack;
		}
	}
}