package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadFollowUpByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadFollowUpByPatientIdPagedEvent()
		{
			super(VBController.LOAD_FOLLOW_UP_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}