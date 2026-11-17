package com.gazuntite.provider.live.services.billing.event.report
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;
	import com.gazuntite.provider.live.services.billing.dto.PendingBillsDTO;

	public class SuperBillSummaryReportEvent extends CairngormEvent
	{
		public var selectedBill:PendingBillsDTO;
		public var callback:Function = null ;		
		
		public function SuperBillSummaryReportEvent(selectedBill:PendingBillsDTO, callback:Function = null)
		{
			super( BillingController.SUPER_BILL_SUMMARY_REPORT_EVENT );
			
			this.callback = callback;
			this.selectedBill = selectedBill;
		}
	}
}