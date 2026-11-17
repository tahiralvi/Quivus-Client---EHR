package com.gazuntite.provider.live.services.billing.event.report
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class ERAClaimDetailReportEvent extends CairngormEvent
	{
		public var ERAClaimDetailXML:XML;
		public var callback:Function = null ;
		
		public function ERAClaimDetailReportEvent(ERAClaimDetailXML:XML, callback:Function = null)
		{
			super(BillingController.ERA_CLAIM_DETAIL_REPORT_EVENT);
			
			this.ERAClaimDetailXML = ERAClaimDetailXML;
			this.callback = callback;
		}
	}
}