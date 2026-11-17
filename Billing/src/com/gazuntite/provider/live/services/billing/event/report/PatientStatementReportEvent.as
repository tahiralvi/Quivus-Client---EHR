package com.gazuntite.provider.live.services.billing.event.report
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.billing.appController.BillingController;

	public class PatientStatementReportEvent  extends CairngormEvent
	{
		public var statementXML:XML;
		public var callback:Function = null ;
		
		public function PatientStatementReportEvent(statementXML:XML, callback:Function = null)
		{
			super(BillingController.PATIENT_STATEMENT_REPORT_EVENT);
			
			this.statementXML = statementXML;
			this.callback = callback;
		}
	}
}