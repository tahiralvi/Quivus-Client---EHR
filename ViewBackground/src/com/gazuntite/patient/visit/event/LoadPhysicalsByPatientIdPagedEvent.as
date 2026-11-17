package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadPhysicalsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadPhysicalsByPatientIdPagedEvent()
		{
			super(VBController.LOAD_PHYSICALS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}