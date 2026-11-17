package com.gazuntite.common.event.recommendation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadAllRecommendationPlanTypesEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadAllRecommendationPlanTypesEvent(_model:Object)
		{
			super(QSCommonController.LOAD_ALL_RECOMMENDATION_PLAN_TYPES_EVENT);
			
			model = _model;
		}
	}
}