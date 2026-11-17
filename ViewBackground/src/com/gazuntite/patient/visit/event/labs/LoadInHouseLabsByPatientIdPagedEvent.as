package com.gazuntite.patient.visit.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.gazuntite.skins.chrome.buttonSkins.superBillAddButton;
	import com.gazuntite.patient.visit.controller.VBController;
	import com.gazuntite.patient.visit.dto.PageDTO;

	public class LoadInHouseLabsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadInHouseLabsByPatientIdPagedEvent()
		{
			super(VBController.LOAD_IN_HOUSE_LABS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}