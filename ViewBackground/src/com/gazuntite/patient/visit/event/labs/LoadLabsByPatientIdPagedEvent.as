package com.gazuntite.patient.visit.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadLabsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadLabsByPatientIdPagedEvent()
		{
			super (VBController.LOAD_LABS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}