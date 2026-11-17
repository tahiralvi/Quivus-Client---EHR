package com.gazuntite.patient.visit.event.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadChronicDiagnosisByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadChronicDiagnosisByPatientIdPagedEvent()
		{
			super(VBController.LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}