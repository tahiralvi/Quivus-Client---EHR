package com.gazuntite.provider.live.services.elab.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.live.services.elab.appController.ELabsController;
	
	public class LoadPatientLabOrdersByClinicIdEvent extends CairngormEvent
	{
		
		public var pageNo 		: int;
		
		public function LoadPatientLabOrdersByClinicIdEvent( pageNo : int )
		{
			super( ELabsController.LOAD_PATIENT_LAB_ORDER_BY_CLINIC_ID_EVENT );
			this.pageNo = pageNo;
		}
	}
}