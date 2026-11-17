package com.gazuntite.provider.live.services.billing.event.accountsAndReceiveables
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class AdjustmentMappingEvent extends CairngormEvent
	{
		public var xmlDocument		:XML;
		public var callBack			:Function;
		
		public function AdjustmentMappingEvent(xmlDocument:XML = null, callBack:Function = null)
		{
			super(BillingController.ADJUSTMENT_MAPPING_EVENT);
			
			this.xmlDocument    = xmlDocument;
			this.callBack 		= callBack;
		}
	}
}