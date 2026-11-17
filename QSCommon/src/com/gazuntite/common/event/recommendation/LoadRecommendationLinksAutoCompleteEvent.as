package com.gazuntite.common.event.recommendation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadRecommendationLinksAutoCompleteEvent extends CairngormEvent 
	{
		public var searchString:String;
		public var model:Object;
		
		public function LoadRecommendationLinksAutoCompleteEvent(searchString:String, _model:Object)
		{
			super(QSCommonController.LOAD_RECOMMENDATION_LINK_AUTO_COMPLETE_EVENT);
			
			this.searchString = searchString;
			this.model = _model;
		}
	}
}