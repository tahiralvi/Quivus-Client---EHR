package com.gazuntite.common.event.recommendation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadAllRecommendationDurationTypesEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadAllRecommendationDurationTypesEvent(_model:Object)
		{
			super (QSCommonController.LOAD_ALL_DURATION_TYPES_EVENT);
			
			model = _model;
		}
	}
}