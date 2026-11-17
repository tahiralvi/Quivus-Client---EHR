package com.gazuntite.common.event.labs
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.appController.QSCommonController;
	
	public class LoadLabTypeStaticDataEvent extends CairngormEvent
	{
		public var model:Object;
		
		public function LoadLabTypeStaticDataEvent(_model:Object)
		{
			super (QSCommonController.LOAD_LAB_TYPE_STATIC_DATA_EVENT);
			
			model = _model;
		}
	}
}