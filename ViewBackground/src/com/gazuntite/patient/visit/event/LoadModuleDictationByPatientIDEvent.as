package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadModuleDictationByPatientIDEvent extends CairngormEvent
	{
		public function LoadModuleDictationByPatientIDEvent()
		{
			super(VBController.LOAD_MODULE_DICTATION_BY_PATIENT_ID_EVENT);
		}
	}
}