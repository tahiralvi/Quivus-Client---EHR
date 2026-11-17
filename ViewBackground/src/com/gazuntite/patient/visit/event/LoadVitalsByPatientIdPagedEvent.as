package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadVitalsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadVitalsByPatientIdPagedEvent()
		{
			super (VBController.LOAD_VITALS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}