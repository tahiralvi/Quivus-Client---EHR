package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadHPIByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadHPIByPatientIdPagedEvent()
		{
			super (VBController.LOAD_HPI_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}