package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	
	public class LoadLabResultsByClinicBranchIdEvent extends CairngormEvent
	{
		public var pageNo 		: int;
		
		public function LoadLabResultsByClinicBranchIdEvent( pageNo : int )
		{
			super( ELabsController.LOAD_LAB_RESULTS_BY_CLINIC_ID_EVENT );
			this.pageNo = pageNo;
		}
	}
}