package com.gazuntite.patient.visit.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.VBController;
	
	public class LoadRecommendationByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadRecommendationByPatientIdPagedEvent()
		{
			super(VBController.LOAD_RECOMMENDATION_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}