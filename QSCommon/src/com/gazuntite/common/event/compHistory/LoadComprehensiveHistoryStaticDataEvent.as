package com.gazuntite.common.event.compHistory
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadComprehensiveHistoryStaticDataEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadComprehensiveHistoryStaticDataEvent(_model:Object)
		{
			super(QSCommonController.LOAD_COMPREHENSIVE_HISTORY_STATIC_DATA);
			
			this.model = _model;
		}
	}
}