package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	
	public class ProcessLabOrderByCriteriaEvent extends CairngormEvent
	{
		public var Criteria:String;
		public function ProcessLabOrderByCriteriaEvent(criteria:String)
		{
			super(ELabsController.PROCESS_LAB_ORDER_BY_CRITERIA, true, false);
			this.Criteria = criteria;
		}
	}
}