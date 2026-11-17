package com.gazuntite.patient.visit.event.compHistory
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadSocialHistoryByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadSocialHistoryByPatientIdPagedEvent()
		{
			super(VBController.LOAD_SOCIAL_HISTORY_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}