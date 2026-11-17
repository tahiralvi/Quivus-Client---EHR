package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	
	public class ProcessLabResultByCriteriaEvent extends CairngormEvent
	{
		public var Criteria:String;
		public function ProcessLabResultByCriteriaEvent(criteria:String)
		{
			super(ELabsController.PROCESS_LAB_RESULT_BY_CRITERIA, true, false);
			this.Criteria = criteria;
		}
	}
}