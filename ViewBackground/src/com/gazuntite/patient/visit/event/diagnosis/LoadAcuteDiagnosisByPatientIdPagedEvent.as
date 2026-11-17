package com.gazuntite.patient.visit.event.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadAcuteDiagnosisByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadAcuteDiagnosisByPatientIdPagedEvent()
		{
			super(VBController.LOAD_ACUTE_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}