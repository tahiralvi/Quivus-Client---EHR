package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	
	public class LoadROSByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadROSByPatientIdPagedEvent()
		{
			super (VBController.LOAD_ROS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}