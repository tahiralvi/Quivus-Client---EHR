package com.gazuntite.patient.visit.event.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.gazuntite.skins.chrome.buttonSkins.superBillAddButton;
	import com.gazuntite.patient.visit.controller.VBController;

	public class LoadResolvedDiagnosisByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadResolvedDiagnosisByPatientIdPagedEvent()
		{
			super(VBController.LOAD_RESOLVED_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}