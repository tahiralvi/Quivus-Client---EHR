package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;
	import com.gazuntite.patient.visit.utlis.VBConstants;
	
	public class LoadPatientImmunizationsByPatientIdEvent extends CairngormEvent
	{
		public function LoadPatientImmunizationsByPatientIdEvent()
		{
			super (VBController.LOAD_PATIENT_IMMUNIZATIONS_BY_PATIENT_ID_EVENT);
		}
	}
}