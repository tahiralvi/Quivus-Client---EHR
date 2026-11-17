package com.gazuntite.patient.visit.event.compHistory
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadMedicalHistoryByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadMedicalHistoryByPatientIdPagedEvent()
		{
			super(VBController.LOAD_MEDICAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}