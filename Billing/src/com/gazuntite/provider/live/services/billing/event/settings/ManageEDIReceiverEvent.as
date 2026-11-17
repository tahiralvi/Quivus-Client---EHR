package com.gazuntite.provider.live.services.billing.event.settings
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ManageEDIReceiverEvent extends CairngormEvent
	{
		public var xmlDocument		:XML;
		public var callBack			:Function;
		
		public function ManageEDIReceiverEvent(xmlDocument:XML, callBack:Function = null)
		{
			super(BillingController.MANAGE_EDI_RECEIVER_EVENT);
			
			this.xmlDocument     =  xmlDocument;
			this.callBack		 =  callBack;
		}
	}
}