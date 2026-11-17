package com.gazuntite.common.event.recommendation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadAllRecommendationMethodTypesEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadAllRecommendationMethodTypesEvent(_model:Object)
		{
			super(QSCommonController.LOAD_ALL_RECOMMENDATION_METHOD_TYPES_EVENT);
			
			model = _model;
		}
	}
}